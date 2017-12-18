data目录下存放数据
output目录下测存放试结果
function目录下存放各个预测模型的函数，以及数据预处理函数clean_data.R，数据集划分函数train_test.R
数据处理的主体函数（训练数据用frame_work.R,测试集用submit_frame.R
test目录下存放训练模型汇总函数TEST_all.R，模型分数分析函数score_analysis.R
submit目录下存放测试汇总函数SUBMIT_all.R，模型融合函数merge

--------------------------------------
执行SUBMIT_all.R或（TEST_all.R）查看结果