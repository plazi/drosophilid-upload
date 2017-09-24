for file in *
do
    newname=$(echo $file | tr '.' '_' | sed 's/\(.*\)_\([^_]*\)$/\1.\2/g')
    [ "$newname" != "$file" ] && mv "$file" "$newname"
done
