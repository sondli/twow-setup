# Inspired by TheLinuxITGuy https://github.com/TheLinuxITGuy/TWOW-Setup/

# Define TWOW and addons directories
TWOW_DIR="/home/$USER/Games/turtlewow/drive_c/Program Files (x86)/TurtleWoW"
ADDONS_DIR="$TWOW_DIR/Interface/AddOns"

# Navigate to the AddOns directory
cd "$ADDONS_DIR"

# List all addons to install
declare -a ADDONS=(
"shagu/pfQuest"
"shagu/pfQuest-turtle"
"shagu/pfUI"
"shagu/pfUI-eliteoverlay"
"shagu/ShaguDPS"
"doorknob6/pfUI-turtle"
"balakethelock/SP_SwingTimer"
"balakethelock/SuperAPI"
"MarcelineVQ/Roid-Macros"
"Lexiebean/AtlasLoot"
"pepopo978/BetterCharacterStats"
#"tdymel/DPSMate"
"laytya/KLHThreatMeter"
"gwetchen/aux-addon-turtle"
"mitjafelicijan/TurtleTweaks"
"sondli/blockvalue"
"MarcelineVQ/TankPlates"
)

#Install all addons
for ADDON in "${ADDONS[@]}"
do 
	FOLDER=`cut -d "/" -f2- <<< "$ADDON"`

	if [ "$FOLDER" = "aux-addon-turtle" ] && [ -d "./aux-addon" ]; then
		echo "Already installed: aux-addon-turtle"
		continue
	fi

	if [ -d "./$FOLDER" ]; then
		echo "Already installed: ${FOLDER}"
	else
		git clone "https://github.com/${ADDON}.git"
		if [ -d "./aux-addon-turtle" ]; then
			mv ./aux-addon-turtle ./aux-addon
		fi
		if [ $FOLDER == "DPSMate" ]; then
			mv ./DPSMate ./DPSMateTEMP
			mv ./DPSMateTEMP/* ./
			rm -rf ./DPSMateTEMP
		fi
	fi
done

# Install SuperWoW
SUPERWOW_VERSION="1.1.3"
echo "Do you wish to install SuperWoW ${SUPERWOW_VERSION}?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) 
					cd "$TWOW_DIR"
					wget https://github.com/balakethelock/SuperWoW/releases/download/Release/SuperWoW.release.${SUPERWOW_VERSION}.zip
					unzip -o SuperWoW.release.${SUPERWOW_VERSION}.zip
					rm SuperWoW.release.${SUPERWOW_VERSION}.zip; break;;
        No ) exit;;
    esac
done

