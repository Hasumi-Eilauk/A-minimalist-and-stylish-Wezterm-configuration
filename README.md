# A simple yet elegant wezterm configuration theme
# 一款简单并优雅的wezterm配置主题

**截图一**

<img width="1644" height="962" alt="image" src="https://github.com/user-attachments/assets/fa3e3dd5-7366-48c5-ab1f-f019c9d33926" />

**截图二**
<img width="1667" height="912" alt="image" src="https://github.com/user-attachments/assets/88d2c276-92d0-42af-820c-5908f49da157" />
**截图三**
<img width="1667" height="912" alt="image" src="https://github.com/user-attachments/assets/1624ada6-ccee-468f-8e52-211c38bf8f76" />




## 前提条件

**1、安装`wezterm`终端**

[WezTerm终端](https://github.com/wezterm/wezterm/releases)

**2、安装`nerdfont`字体**

[Nerd Font](https://www.nerdfonts.com/font-downloads)

然后下载SylBols Nerd Font  和  DejaVuSansm Nerd Font字体
然后将他们放在~/.fonts/ 或 ~/.local/share/fonts/目录下
最后使用fc-cache -fv命令来刷新一下字体


## 使用教程

1、下载或克隆压缩包到本地

2、将压缩包解压

3、将解压后的文件放入：`$HOME/.config/wezterm`目录底下

Windows目录：C:\Users\Fizz\.config\wezterm

Llinux目录：$HOME/.config/wezterm

Macos目录：~/.config/wezterm 

安装完后重启你的wezterm终端，即可享受~  

## 快捷键

```bash
#快捷键
Ctrl+shift+c    --复制
鼠标右键         --粘贴
Ctrl+shift+v    --粘贴
Ctrl+shift+r    --重命名标签栏
Ctrl+alt+[\]    --水平拆分窗格，即左右拆分
Ctrl+alt+[/]    --垂直拆分窗格，即上下拆分
Ctrl+alt+[-]    --关闭当前窗格
Ctrl+alt+z      --最大化/最小化当前窗格
F11             --全屏
Ctrl+alt+[↑]    --向上扩展窗格
Ctrl+alt+[↓]    --向下扩展窗格
Ctrl+alt+[←]    --向左扩展窗格
Ctrl+alt+[→]    --向右扩展窗格
Alt+[↑]         --放大字体
Alt+[↓]         --缩小字体
Alt+r           --重置字体大小
```

#更新日志：
```bash
2025年8月13日
*优化了代码,将所有配置的文件进行修改优化，代码显示思路更清晰，逻辑明确。 
*所有重要配置文件代码增加了大量注释，即使你是lua语言小白也能更好的掌握wezterm配置。 
*修改了新的右标签栏，增加了显示日期，显示时间功能。 
*增加了随机彩色标签栏。 
