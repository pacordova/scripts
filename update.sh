#!/bin/bash


if [ "$#" -eq 0 ]; then

cd ..

rm -fr BigWigs* Capping* ItemRack* WeakAuras* WowSimsExporter
rm -fr CharacterStatsClassic ThreatClassic2 aux-addon TrinketMenu
rm -fr Auctionator OmniCC* tullaRange
rm -fr Grid2* unitscan

scripts/update.sh -t auto -u Resike      TrinketMenu
scripts/update.sh -t zip  -u BigWigsMods BigWigs
scripts/update.sh -t zip  -u BigWigsMods BigWigs_Classic
scripts/update.sh -t zip  -u dfherr      ThreatClassic2
scripts/update.sh -t zip  -u getov       CharacterStatsClassic
scripts/update.sh -t zip  -u WeakAuras   WeakAuras2
scripts/update.sh -t zip  -u michaelnpsp grid2 --filter=classic
scripts/update.sh -t zip  -u tullamods   OmniCC
#scripts/update.sh -t zip  -u tullamods   tullaRange
#scripts/update.sh -t zip  -u BigWigsMods Capping
#scripts/update.sh -t auto -u voidzone    gnosis
#scripts/update.sh -t auto -u shirsig     unitscan
#scripts/update.sh -t auto -u shirsig     aux-addon
#scripts/update.sh -t auto -u Auctionator Auctionator

rm -fr BigWigs_{KhazAlgar,LiberationOfUndermine,NerubarPalace,ManaforgeOmega}
rm -fr OmniCC_Config tullaRange_Config
rm -f ../../../Data/indices/*

exit 0

fi

while [[ "$#" -gt 0 ]]; do
case "$1" in
  -t)
    RELEASETYPE="$2" && shift ;;
  --filter=*)
    EXTRAFILTER="${1#*=}"     ;;
  -u)
    REPOUSER="$2" && shift    ;;
  *)
    REPONAME="$1"             ;;
esac
shift
done

printf "url: %s/%s/%s\n" "https://github.com" "$REPOUSER" "$REPONAME"

case "$RELEASETYPE" in
  zip) 
    curl -s "https://api.github.com/repos/$REPOUSER/$REPONAME/releases/latest" \
    | awk '/browser_download_url.*'$EXTRAFILTER'.*zip/{print $2}' \
    | xargs curl -L -# @- \
    | bsdtar x
    ;;
  auto)
    rm -fr "$REPONAME" && mkdir -p "$REPONAME"
    curl -s "https://api.github.com/repos/$REPOUSER/$REPONAME/releases/latest" \
    | awk '/tarball_url/{print $2}' \
    | tr -d , \
    | xargs curl -L -# @- \
    | pigz -cd \
    | tar -C "$REPONAME" --strip-components=1 -x
    ;;
esac
