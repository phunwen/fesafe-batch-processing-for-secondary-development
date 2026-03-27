# fesafe-batch-processing-for-secondary-development
Batch processing of finite element simulation results was carried out using fe-safe


# fesafe-batch-processing-for-secondary-development
Batch processing of finite element simulation results was carried out using fe-safe

# fe-safe-batch-processing-for-secondary-development
Batch automated fatigue life processing for Abaqus `.odb` results using **fe-safe_cl.exe** (command-line version of fe-safe).

## Overview
Official fe-safe documentation provides very limited guidance on batch processing. Most content only covers macro recording and basic GUI operations. (For more detail about macro, plz see use guide chapter 23)

If you need to automatically process hundreds of `.odb`files in batch, **you cannot use `fe-safe.exe` (the interactive GUI)**. The GUI only supports one analysis at a time and closes after completion, making true batch automation impossible.

Instead, you must use **`fe-safe_cl.exe`** (installed automatically with fe-safe), the **headless command-line tool** that runs in the background without a GUI and supports fully automated batch workflows.

## Core Principle
The batch script (`*.bat`) works as follows:
1. Loop through all `.odb` files in a folder
2. generate a **temporary macro file** for each model
3. Pass the macro to `fe-safe_cl.exe` for background processing
4. Delete the temporary macro after completion
5. Repeat until all files are processed

This `.bat` script is designed to **automatically process up to 100 `.odb` files** without manual intervention.

## Required Pre-Setup (GUI Configuration)
Before running the batch script, you must configure two critical files in the fe-safe GUI:

### 1. Load File (`*.ldf`)
Define your fatigue load configuration in the fe-safe GUI:
- Select load datasets (this project uses a periodic load from dataset 2 to 1200)
- Save as a `.ldf` file for batch processing

### 2. Analysis Setup File (`*.stli`)
Define material properties, fatigue algorithms, analysis settings, and output controls in the fe-safe GUI:
- Material parameters
- Fatigue calculation method
- Solver options
- Save as a `.stli` setup file











基于 fe-safe 实现有限元仿真结果（ODB）的批量疲劳分析
在查阅 fe-safe 官方文档后，我发现关于批量处理的说明非常少，大部分内容仅围绕宏文件（macro）展开。
实际上，如果你想批量自动化处理 .odb 结果文件，不能使用 fe-safe.exe—— 这是图形交互界面，一次只能计算一个模型，计算完成后会自动退出，无法实现连续批量处理。

正确的方式是使用 fe-safe_cl.exe（安装 fe-safe 时自动附带），它是无界面的命令行工具，可以在后台静默运行，不会自动关闭，非常适合批量自动化。

基本原理
    通过 .bat 批处理文件实现全自动循环：
    每次循环动态生成一个临时宏文件（.macro）
    将临时宏传递给 fe-safe_cl.exe 执行
    执行完成后自动删除临时宏
    继续处理下一个文件，直到全部完成
本项目中的 .bat 脚本可实现自动循环处理 100 组 .odb 文件，无需人工干预。


前置准备（必须在图形界面完成）
    载荷谱文件（.ldf）
在 fe-safe 图形界面中配置好载荷谱，例如指定使用哪些增量步（本项目中使用 2–1200 步作为一个载荷周期），保存为 .ldf 文件。
    
    分析配置文件（.stli）
在图形界面中设置好材料参数、疲劳算法、分析类型、输出选项，保存为 .stli 项目配置文件。
宏脚本仅负责加载模型、读取应力、执行分析，不负责材料与载荷的核心配置。
