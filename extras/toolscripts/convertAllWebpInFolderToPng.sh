#!/bin/bash

inputTargetDir=$1
targetDir="$inputTargetDir"

animatedWebpFileList=""

# NOTES ------------------------------------------------------------------------------------
# By design, this script does not delete any files at any point - you have to clear up the webp files manually after youve converted them in case you set the dir wrong and it deletes a load of files or disks!!

# Callable from my .bashrc, as convertAllWebpInFolderToPng
# Goes through all webp files in a folder, checks whether theyre animated webps, if theyre not animated
# then it converts them to .png

# Note:
# * it is non-recursive, it does not go into subfolders of the current folder
# * that the output .pngs are quite large in size

# Tests:
# * tested against having other files in the same folder and they werent touched, as expected.
# * tested against animated webp files, works now.

# ------------------------------------------------------------------------------------------

echo "Convert all .webp files in following directory into .png files? Directory:"
echo "$targetDir"
echo "Is this correct? [y/n]."
read userYInput
if [ $userYInput != 'y' ]
then
    echo "You must enter y to continue."
else
    echo "Starting..."
    let numConverted=0
    for item in "$targetDir"/*
    do
        # echo $item
        if [ -f "$item" ];
        then
            # the file command just spits out file information metadata etc about filetype
            fileTestResult=$(file "$item")
            fileTestResultWithQuotes="$fileTestResult" # put it in quotes so dirname spaces are honoured
            search="Web/P"
            if [[ "$fileTestResultWithQuotes" == *"$search"* ]];
            then
                # weve found a webp file - lets test if its an animated one first
                webpinfoTestResult=$(webpinfo "$item")
                webpinfoTestResultWQuotes="$webpinfoTestResult"
                searchWebpAnim="ANIM" #if it contains this text then its an animated webp
                let itsAnAnimatedWebp=0
                if [[ "$webpinfoTestResult" == *"$searchWebpAnim"*  ]];
                then
                    echo "animated file detected"
                    let itsAnAnimatedWebp=1
                fi
                if [[ itsAnAnimatedWebp -eq 1 ]];
                then
                    # add it to a list to output at the end, dont do anything else to it
                    animatedWebpFileList="${animatedWebpFileList} \n $item"
                else
                    # convert the static (not animated, as above) .webp file to png using dwebp
                    newFileName=${item%.webp} # removes the .webp from the filename
                    newFileName="$newFileName.png" #adds the .png extension to the filename
                    dwebp "$item" -o "$newFileName" #dwebp inputfilename -o outputfilename
                    let numConverted++
                fi
            fi 
        fi
    done
    if [ $numConverted -gt 0 ]; then
        printf "\n\n Finished. $numConverted converted.\n\n"
        if [[ $animatedWebpFileList = "" ]]; then
            echo "Animated Webp list:"
            echo " No animated webps were detected, so its safe to remove all .webps in this folder"
        else 
            echo " However, these specific files were NOT converted, as they are unconvertable ANIMATED .webps:"
            printf "$animatedWebpFileList"
            printf "\n\n Steps:\n"
            printf "\n 1. Move the animated .webp files listed above somewhere else.\n"
            printf "\n 2. Delete all the other .webp files as you have now converted them to .webp.\n"
        fi

    fi
fi



