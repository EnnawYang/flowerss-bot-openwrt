# flowerss-bot-openwrt  

A telegram bot for rss reader for openwrt .  

瞎抄的，我小白一个，不提供技术支持  
只有主程序，没有Luci(不会写)  
怎么配置以及使用请参考原作者说明  
  
编译:  
```
git clone https://github.com/EnnawYang/flowerss-bot-openwrt  
make menuconfig  
choose Network -> Telegram Bot -> flowerss-bot  
make -j1 V=s  
```  

程序位置：`/usr/bin/flowerss-bot`  
配置文件：`/home/flowerss-bot/config.yml`  
目录下的`config.yml.sample`为配置模版  

type `flowerss-bot --help` to see how to get started.  

# 原作者以及使用方法  
https://github.com/indes/flowerss-bot  
https://flowerss-bot.now.sh
