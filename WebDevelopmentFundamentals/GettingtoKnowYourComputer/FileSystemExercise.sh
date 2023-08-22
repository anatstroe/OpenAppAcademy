#!/bin/bash
mkdir exercisedir
cd exercisedir

folders="one two three"
subfolders="alpha beta gamma"
names="fever secret under-over outside"

for folder in $folders; do
  mkdir -p $folder
  for subfolder in $subfolders; do
    mkdir -p $folder/$subfolder
  done
done

touch one/alpha/secret.txt one/beta/secret.txt one/gamma/under-over.txt
touch two/alpha/under-over.txt two/beta/fever.txt two/gamma/fever.txt
touch three/alpha/outside.txt three/beta/outside.txt three/gamma/secret.txt

echo "Step 1"
tree

for name in $names; do
    mkdir -p $name
    find . -type f -name "*$name*" > $name/files.txt
    while read nameOfFile; do
        newNameOfFile=${nameOfFile#*./}
        newNameOfFile=$(echo $newNameOfFile | tr '/' '-')
        newNameOfFile=$(echo "$newNameOfFile" | sed "s/-${name}.txt/.txt/")
        mv $nameOfFile $name/$newNameOfFile
    done < $name/files.txt
    rm $name/files.txt
done

echo "Step 2"
tree

find * -type d -empty -delete
echo "Step 3"
tree

find . -type f -name "*beta*" -delete
echo "Step 4"
tree

cd ..
rm -rf exercisedir
