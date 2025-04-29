package com.atguigu.java;

/**
 * @author yangda
 * @create 2025-04-29-2:33
 * @description:
 * 经过测试，该脚本可以正确替换掉对应的图片链接地址。
 *
 *
 * 代码说明
 * 文件遍历：使用 Files.walk 遍历指定文件夹及其子目录，过滤出 .md 文件。
 *
 * 替换逻辑：读取每个文件内容，替换前缀后写回文件。
 *
 * 编码：默认使用 UTF-8 编码。如果你的 .md 文件使用其他编码（例如 GBK），可以修改 StandardCharsets.UTF_8 为 Charset.forName("GBK")：
 * java
 *
 * String content = new String(Files.readAllBytes(filePath), Charset.forName("GBK"));
 * Files.write(filePath, newContent.getBytes(Charset.forName("GBK")));
 *
 * 注意事项
 * 备份文件：运行前建议备份文件夹，以防替换出错。
 *
 * 权限问题：确保程序对文件夹有读写权限。
 *
 * 依赖：此代码使用 Java 7+ 的 NIO 包，无需额外依赖。
 *
 * 异常处理：程序包含基本的异常处理，遇到错误会打印信息。
 *
 * 运行后，指定文件夹下所有 .md 文件中的图片链接前缀都会被替换为新地址。
 */
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class ReplaceImagePrefix {
    public static void main(String[] args) {
        // 定义文件夹路径（替换为你的文件夹路径）。将 folderPath 替换为你的 .md 文件所在的文件夹路径
        String folderPath = "D:\\Java_developer_tools\\uploadfiles\\testReplaceImgsPath"; // 例如 "C:/path/to/your/folder" 或 "./md_files"
        String oldPrefix = "https://raw.githubusercontent.com/EXsYang/PicGo-images-hosting/main/images/";
        String newPrefix = "https://imgs.vrchat.vip/img/";

        // 遍历文件夹
        try {
            Files.walk(Paths.get(folderPath))
                    .filter(path -> path.toString().endsWith(".md")) // 只处理 .md 文件
                    .forEach(path -> replacePrefixInFile(path, oldPrefix, newPrefix));
        } catch (IOException e) {
            System.err.println("遍历文件夹时发生错误: " + e.getMessage());
        }
    }

    private static void replacePrefixInFile(Path filePath, String oldPrefix, String newPrefix) {
        try {
            // 读取文件内容
            String content = new String(Files.readAllBytes(filePath), StandardCharsets.UTF_8);
            // 替换前缀
            String newContent = content.replace(oldPrefix, newPrefix);
            // 如果内容有变化，写回文件
            if (!content.equals(newContent)) {
                Files.write(filePath, newContent.getBytes(StandardCharsets.UTF_8));
                System.out.println("已处理: " + filePath);
            }
        } catch (IOException e) {
            System.err.println("处理文件 " + filePath + " 时发生错误: " + e.getMessage());
        }
    }
}
