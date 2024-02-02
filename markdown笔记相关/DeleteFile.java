import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class DeleteFile {

    public static void main(String[] args) {
	
	//编译时使用 javac -encoding UTF-8 C:\Users\yangd\Desktop\DeleteFile.java
	
	// java -cp C:\Users\yangd\Desktop DeleteFile
        Scanner scanner = new Scanner(System.in);
        List<String> filePaths = new ArrayList<>();

        System.out.println("请输入要删除的文件的完整路径，输入'exit'结束：");
        while (true) {
            String input = scanner.nextLine();
            if ("exit".equalsIgnoreCase(input)) {
                break;
            }
            // 格式化路径，将单个反斜杠替换为双反斜杠
            String formattedPath = input.replace("\\", "\\\\");
            filePaths.add(formattedPath);
        }

        // 遍历文件路径列表并尝试删除每个文件
        for (String filePath : filePaths) {
            File file = new File(filePath);
            boolean success = file.delete();
            if (success) {
                System.out.println("Deleted successfully: " + filePath);
            } else {
                System.out.println("Failed to delete: " + filePath);
            }
        }
    }
}
