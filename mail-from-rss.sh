RSS_SITE=$1
CHECK_INTERVAL=10
PREVIOUS_LINK=''
LARGE_SIZE='564x'

while [ 1 ]; do
    CURRENT_LINK=$(rsstail -i 1 -u $RSS_SITE -l -n 1 -1 | grep -o 'https://www.pinterest[^"]*')
    IMAGE_URL=$(rsstail -i 1 -u $RSS_SITE -d -n 1 -1 | grep -o 'https://i.pinimg[^"]*')

    IMAGE_URL="${IMAGE_URL/236x/$LARGE_SIZE}"

    if [ "$CURRENT_LINK" != "" ] && [ "$CURRENT_LINK" != "$PREVIOUS_LINK" ]; then
        echo "LINK: $CURRENT_LINK"
        echo "IMAGE_URL: $IMAGE_URL"
        echo $CURRENT_LINK | mutt -s $IMAGE_URL trigger@applet.ifttt.com
        PREVIOUS_LINK=$CURRENT_LINK
    fi

    sleep $CHECK_INTERVAL
done
