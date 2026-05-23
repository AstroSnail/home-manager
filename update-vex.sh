set -e
curl --config vex.curlrc
python3 bsky-car-to-fortune.py <vex-dragon.bsky.social.car | fmt --split-only >vex
