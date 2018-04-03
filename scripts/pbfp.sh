#!bin/bash

#usage pbfp -i images/ -s scene/

function printHelp{
	echo "--------------------------------------------------------------------------------"
	echo "Help page"
	echo ""
	echo "-i or --images is used to specify the path to the images used for generation"
	echo "-s or --scene is the location where you want the ouput to go (this should be a non existing directory)"
	echo ""
	echo "example usage"
	echo "pbfp -i building_images -s buidling_ply"
	echo "pbfp --images img --scene output_scene"
	echo "pbfp --help"
	echo ""
	echo "extra information"
	echo "when you specify the images and the scene do not use a / this can cause issues"
	echo "this script should be called inside the directory where mve and smvs are installed."
	echo "--------------------------------------------------------------------------------"
}
while [[ $# -gt 0 ]]
do
key="$1"
helparg="no"

case $key in
    -i|--images)
    images="$2"
    shift # past argument
    shift # past value
    ;;
    -s|--scene)
    scene="$2"
    shift # past argument
    shift # past value
    ;;
    -h|--help)
    $helparg="yes"
    shift # past argument
    shift # past value
    ;;
esac
done

if [ $helparg = "yes" ];
	printHelp
fi

if [[ -v $images ]]; 
then 
	echo "images is unset";
	echo "use --help or -h for more information"; 
else
	if [[ -v $scene ]]; 
	then 
		echo "scene is unset"; 
		echo "use --help or -h for more information"; 
	else
		./mve/apps/makescene/makescene -i $images/ $scene/
		./mve/apps/sfmrecon/sfmrecon $scene/
		./smvs/app/smvsrecon $scene/
		./mve/apps/fssrecon/fssrecon $scene/smvs-B2.ply $scene/smvs-surface.ply
		./mve/apps/meshclean/meshclean -p10 $scene/smvs-surface.ply $scene/smvs-clean.ply
	fi
fi

