使用步骤：

1.下载“.bat”启动文件

2.修改bat文件：“你的llama.cpp启动文件目录”、“你的模型目录”

3.保存.bat文件，双击启动llama



注意事项：

一、只有所需的视觉模型（mmproj）是同一个才能放同一个文件夹，否则必须单独存放。

存放示例如下：

<img width="330" height="92" alt="image" src="https://github.com/user-attachments/assets/6ff2d129-62c4-450f-818d-4bb6ee20f88e" />

<img width="169" height="59" alt="image" src="https://github.com/user-attachments/assets/007035fa-b6a2-42ff-b2d3-887cbb8e2d30" />

二、自行更改上下文大小

-c 131072：将总上下文扩大到 128k

--parallel 1 确保这 128k 空间全额完整地留给当前这一个对话

<img width="588" height="220" alt="image" src="https://github.com/user-attachments/assets/470d1a6e-db16-4eb5-9fe8-b9a5fb31831a" />
