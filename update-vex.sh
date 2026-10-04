set -e
# TODO: getopt -f fetch anyway
if ! [ -f vex-dragon.bsky.social.car ]
then curl --config vex.curlrc
fi
python3 bsky-car-to-fortune.py <vex-dragon.bsky.social.car | fmt --split-only >vex
