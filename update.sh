#!/bin/bash

cd `dirname "$0"`/..

_fetch_release_gh(){
  printf "%s\n" "$1"
  curl -s "https://api.github.com/repos/$1/releases/latest" \
  | awk '/browser_download_url.*zip/{print $2}' \
  | tr -d , \
  | xargs curl -L -# @- \
  | bsdtar x
}

_fetch_release_classic(){
  printf "%s\n" "$1"
  curl -s "https://api.github.com/repos/$1/releases/latest" \
  | awk '/browser_download_url.*zip/{print $2}' \
  | tr -d , \
  | grep -e '[Cc]lassic' \
  | xargs curl -L -# @- \
  | bsdtar x
}

_fetch_tag_gh(){
  printf "%s\n" "$1"
  curl -s "https://api.github.com/repos/$1/tags" \
  | awk '/zipball_url/{print $2;exit;}' \
  | tr -d , \
  | xargs curl -L -# @- \
  | bsdtar x
}

# Fresh install
rm -fr BigWigs_{Classic,Core,Options,Plugins}
rm -fr BigWigs_{KhazAlgar,LiberationOfUndermine,NerubarPalace,ManaforgeOmega}
rm -fr Capping
rm -fr ItemRack{Options,}
rm -fr WeakAuras{Archive,ModelPaths,Options,Templates,}
rm -fr WowSimsExporter
rm -fr CharacterStatsClassic
rm -fr ThreatClassic2
rm -fr {OmniCC,tullaRange}{_Config,}
rm -fr Cell
rm -fr Skada
rm -fr {TheMouseNest-,}Auctionator{-*,}
rm -fr {shirsig-,}{aux-addon,unitscan}{-*,}
rm -fr {voidzone-,}gnosis{-*,}
rm -fr {Vysci-,}LFG-Bulletin-Board{-*,} LFGBulletinBoard
rm -fr {Resike-,}TrinketMenu{-*,}

# Backup Grid2 because sometimes there is no classic release in latest
mkdir Grid2.bak
mv Grid2{LDB,Options,RaidDebuffs,RaidDebuffsOptions,} Grid2.bak

repos=(
  'BigWigsMods/BigWigs'
  'BigWigsMods/BigWigs_Classic'
  'BigWigsMods/Capping'
  'dfherr/ThreatClassic2'
  'enderneko/Cell'
  'getov/CharacterStatsClassic'
  'tullamods/OmniCC'
  'tullamods/tullaRange'
  'WeakAuras/WeakAuras2'
# 'wowsims/exporter'
  'zarnivoop/skada'
)
for x in ${repos[@]}; do _fetch_release_gh "$x"; done

repos=(
  'michaelnpsp/Grid2'
  'Rottenbeer/ItemRack'
)
for x in ${repos[@]}; do _fetch_release_classic "$x"; done

repos=(
  'Resike/TrinketMenu'
# 'shirsig/aux-addon'
  'shirsig/unitscan'
# 'TheMouseNest/Auctionator'
# 'voidzone/gnosis'
  'Vysci/LFG-Bulletin-Board'
)
for x in ${repos[@]}; do _fetch_tag_gh "$x"; done

# Rename directories
[ -d *"-aux-addon-"*    ] && mv *"-aux-addon-"*    aux-addon
[ -d *"-unitscan-"*     ] && mv *"-unitscan-"*     unitscan
[ -d *"-TrinketMenu-"*  ] && mv *"-TrinketMenu-"*  TrinketMenu
[ -d *"-gnosis-"*       ] && mv *"-gnosis-"*       Gnosis
[ -d *"-Auctionator-*"  ] && mv *"-Auctionator-"*  Auctionator
[ -d */LFGBulletinBoard ] && mv */LFGBulletinBoard LFGBulletinBoard

# If Grid2 successfully downloaded, delete backup, otherwise restore backup
if [ -d Grid2 ]; then 
    rm -fr Grid2.bak
else 
    mv Grid2.bak/* . && rmdir Grid2.bak
fi

# Cleanup
rm -fr Vysci-LFG-Bulletin-Board-*
rm -fr BigWigs_{KhazAlgar,LiberationOfUndermine,NerubarPalace,ManaforgeOmega}
rm -fr {OmniCC,tullaRange}_Config
rm -f ../../../Data/indices/*
