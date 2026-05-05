#!/bin/bash

#Colours
green="\e[0;32m\033[1m"
end="\033[0m\e[0m"
red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
yellow="\e[0;33m\033[1m"
purple="\e[0;35m\033[1m"
turquoise="\e[0;36m\033[1m"
gray="\e[0;37m\033[1m"
subrayar="\e[4m\033[1m"

function crtl_c(){
  echo -e "\n\n${red}[!] Saliendo...${end}"
  exit 1
  tput cnorm
}

# crtl_c 
trap crtl_c INT

#variables globales 
main_url="https://htbmachines.github.io/bundle.js"

function help_panel(){
  echo -e "\n${yellow}[+] ${end}${gray}Usages:${end}"
  echo -e "\t${purple}h) ${end}${gray}This panel :0${end}"
  echo -e "\t${purple}u) ${end}${gray}Verify updates${end}"
  echo -e "\t${purple}i) ${end}${gray}Search with IP${end}"
  echo -e "\t${purple}m) ${end}${gray}Search machines${end}" 
  echo -e "\t${purple}y) ${end}${gray}Search youtube URL${end}"
  echo -e "\t${purple}d) ${end}${gray}Search machine names for dificulty${end}"
  echo -e "\t${purple}o) ${end}${gray}Search machine for OS${end}"
  echo -e "\t${purple}s) ${end}${gray}Search machine skills${end}"
}

function search_machines ()
{
  machineName="$1"
  machine_name_chacker=$(cat bundle.js | awk "/name: \"$machineName\"/,/resuelta:/" | grep -vE "id:|sku:|resuelta:" | tr -d '""' | tr -d ',' | sed 's/^ *//' | sed 's/:/ =/g' | sed 's/so/os/g')

  if [ "$machine_name_chacker" ]; then 
    echo -e "\n${blue}[+]${end} ${gray}Listing the names of the machine${end} ${turquoise}$machineName${end}${gray}:${end}\n" 
    cat bundle.js | awk "/name: \"$machineName\"/,/resuelta:/" | grep -vE "id:|sku:|resuelta:" | tr -d '""' | tr -d ',' | sed 's/^ *//' | sed 's/:/ =/g' | sed 's/so/os/g'
  else
    echo -e "\n${red} [!] Machine does not exist${end}" 
  fi

}

function hashes (){
md5sumJS=$(md5sum bundle.js | awk '{print $1}')
md5sumTempJS=$(md5sum bundleTemp.js | awk '{print $1}')
  if [ "$md5sumTempJS == $md5sumJs" ]; then 
      echo -e "\n${blue}[+]${end} ${gray}All packages were on day${end}"
  else
      echo -e "\n${blue}[+]${end} ${gray}Updates available${end}"  
      sleep 2
      echo -e "\n${blue}[+]${end} ${gray}Conecting to server...${end}"
      curl -sX GET https://htbmachines.github.io/bundle.js | bat -l js | js-beautify > bundle.js && echo -e "\n ${green}All packages updated succesfully${end}"
      echo -e "\n ${gray} You are on day ${end}"
  fi
}

function updateFiles (){
  if [ ! -f bundle.js ]; then   
    tput civis 
    echo -e "\n${blue}[+]${end} ${gray}Downloading necesary packages${end}" 
    curl -sX GET https://htbmachines.github.io/bundle.js | bat -l js | js-beautify > bundle.js && echo -e "\n${green}[+]${end} ${gray}All packages succesfully instaled${end}"
    tput cnorm
  else 
    tput civis 
    echo -e "\n${red}[!]${end} ${gray}Verifying any update...${end}"
    curl -sX GET https://htbmachines.github.io/bundle.js | bat -l js | js-beautify > bundleTemp.js 
    hashes
    rm -r bundleTemp.js
    tput cnorm
  fi
}

function searchIP ()
{
  IPadress="$1"
  machineName="$(cat bundle.js | grep "ip: \"$IPadress\"" -B 3| grep "name: " | awk 'NF{print $NF}'| tr -d '"' | tr -d ',')"
  if [ "$machineName" ]; then 
    echo -e "\n${yellow}[+]${end}${gray} The machine name of the ip:${end} ${blue}${subrayar}$IPadress${end} ${gray}is:${end} ${purple}$machineName${end} "
  else 
    echo -e "\n${red} [!] IP does not exist${end}"
  fi

}

function search_youtube (){
  youtube="$1"
  youtube_url="$(cat bundle.js | awk "/name: \"$youtube\"/,/resuelta:/" | grep -vE "id:|sku:|resuelta:" | tr -d '"' | tr -d ',' | sed 's/^ *//' | sed 's/so/os/g' | grep youtube | awk 'NF{print$NF}')" 
 
  if [ "$youtube_url" ]; then
    echo -e "\n${yellow}[+]${end}${gray} The machine URL of${end}${blue} $youtube ${end}${gray}is: ${end}${turquoise}${subrayar}$youtube_url${end} "
  else
    echo -e "\n${red} [!] Machine does not exist${end}" 
  fi
}
function search_dificulty (){
  dificulty="$1"
  search_machine_dificulty="$(cat bundle.js | grep "dificultad: \"$dificulty\"" -B 5 | grep name  | tr -d '"' | tr -d ','| awk 'NF {print $NF}' | column)"
  
  if [ "$search_machine_dificulty" ]; then 
    echo -e "\n${gray}All machines with difficulty${end} ${red}$dificulty${end}${gray} are:${end}\n${gray}${subrayar}$search_machine_dificulty${end}\n" 
  else
    echo -e "\n${red}[!] Dificulty does not exist${end}\n"
    echo -e "\n${gray}Dificulties are:${end}"
    echo -e "\n\t${green}[+] Fácil${end}"
    echo -e "\n\t${yellow}[+] Media${end}"
    echo -e "\n\t${red}[+] Difícil${end}"
    echo -e "\n\t${purple}[+] Insane${end}" 
  fi
}
function search_os (){
  OS="$1"
  catalog_by_os="$(cat bundle.js| grep "so: \"$OS\"" -B 5| grep "name:" | tr -d '"' | tr -d ',' | awk 'NF{print $NF}'| column)"
  if [ "$catalog_by_os" ]; then
    echo -e "\n${gray}All machines of${end} ${blue} $OS ${end}${gray} are:${end}\n${gray}$catalog_by_os${end}\n"  
  else
    echo -e "\n${red}[!] Invalid OS${end}\n" 
    echo -e "\n${gray}OS that are available are:${end}"
    echo -e "\n\t${green}[+] Windows${end}"
    echo -e "\n\t${green}[+] Linux${end}"
  fi
}

function getOSDifficultyMachines (){
  dificulty="$1"
  OS="$2"
  hecho="$(cat bundle.js| grep "so: \"$OS\"" -C 4| grep "dificultad: \"$dificulty\"" -B 5 | grep name | tr -d '"' | tr -d ',' | awk 'NF{print $NF}' | column)"  
  if [ "$hecho" ]; then 
    echo -e "\n${gray}$hecho${end}"
  else 
    echo -e "\n${red}[!] Invalid OS${end}\n" 
    echo -e "\n${gray}OS that are available are:${end}"
    echo -e "\n\t${green}[+] Windows${end}"
    echo -e "\n\t${green}[+] Linux${end}"
    echo -e "\n\n\t${red}or${end}"
    echo -e "\n${red}[!] Dificulty does not exist${end}\n"
    echo -e "\n${gray}Dificulties are:${end}"
    echo -e "\n\t${green}[+] Fácil${end}"
    echo -e "\n\t${yellow}[+] Media${end}"
    echo -e "\n\t${red}[+] Difícil${end}"
    echo -e "\n\t${purple}[+] Insane${end}" 
  fi
}
function search_skills (){
  skills=$1
  otro="$(cat bundle.js | grep "skills: " -B 6 | grep "$skills" -i -B 6 | grep "name: " | awk 'NF{print$NF}' | tr -d '"' | tr -d ',' | column)"
  if [ "$otro" ]; then 
   echo -e "\n${gray}$otro${end}" 
  else
    echo -e "\n${red} [!] Invalid option${end}" 
  fi
}

#chivatos 
declare -i chivato_difficulty=0 
declare -i chivato_os=0

# Indicadores 
declare -i parameter_counter=0

while getopts "m:ui:y:d:o:s:h" arg; do 
  case $arg in 
    m) machineName=$OPTARG; let parameter_counter+=1;;
    h) ;;
    i) IPadress=$OPTARG; let parameter_counter+=3;;
    y) youtube=$OPTARG; let parameter_counter+=4;;
    u) let parameter_counter+=2;;
    d) dificulty=$OPTARG; let chivato_difficulty=1; let parameter_counter+=5;;
    o) OS=$OPTARG; let chivato_os=1; let parameter_counter+=6;;
    s) skills=$OPTARG; let parameter_counter+=7;;
  esac
done

if [ $parameter_counter -eq 1 ]; then
  search_machines $machineName
elif [ $parameter_counter -eq 2 ]; then 
  updateFiles
elif [ $parameter_counter -eq 3 ]; then
  searchIP $IPadress
elif [ $parameter_counter -eq 4 ]; then 
  search_youtube $youtube
elif [ $parameter_counter -eq 5 ]; then
  search_dificulty $dificulty
elif [ $parameter_counter -eq 6 ]; then 
  search_os $OS
elif [ $chivato_difficulty -eq 1 ] && [ $chivato_os -eq 1 ]; then 
  getOSDifficultyMachines $dificulty $OS
elif [ $parameter_counter -eq 7 ]; then 
  search_skills $skills
else
  help_panel
fi
