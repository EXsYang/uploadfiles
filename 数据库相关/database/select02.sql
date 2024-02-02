-- select 语句的使用

-- 统计每个学生的总分
SELECT `name`,(chinese + english + math) FROM student;
-- 在所有学生总分 加10分
SELECT `name`,(chinese + english + math + 10) FROM student;
-- 使用别名表示学生分数
SELECT `name` AS '名字', (chinese + english + math) AS total_score
	FROM student;








