//
//  BAPageViewController.m
//  博爱答题
//
//  Created by boai on 15/12/8.
//  Copyright © 2015年 boai. All rights reserved.
//

#import "BAPageViewController.h"
#import "BAScrollPageViewController.h"
#import "BAUtilities.h"
#import "BAButton.h"

#import "BAQuestionBankView.h"


@interface BAPageViewController ()
{
    NSArray *viewControllers;
    BOOL isTimeStart;
}
// navi按钮 - 考题数量
@property (nonatomic, strong) BAButton *testNumberBtn;
// navi按钮 - 时间
@property (nonatomic, strong) BAButton *timeBtn;
// navi按钮 - 收藏
@property (nonatomic, strong) BAButton *collectionBtn;
// navi按钮 - 分享
@property (nonatomic, strong) BAButton *shareBtn;
// 底部View
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation BAPageViewController

// 问题内容
- (NSMutableArray *)testContentArrayM
{
    if (!_testContentArrayM)
    {
        _testContentArrayM = [[NSMutableArray alloc] init];
        
        // 【顺序练习题库】
        if ([self.testVCName isEqualToString:@"BAPageViewController_orderPracticeBtn"])
        {
            [_testContentArrayM addObject:@"【顺序练习题库】仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝"];
            [_testContentArrayM addObject:@"When I am abroad, I always make it a rule never to 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。"];
            [_testContentArrayM addObject:@"After two years in Washington, I often long 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋"];
            [_testContentArrayM addObject:@"It is a profitable thing, if one is wise, to 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝，与慈悲淡然的佛境禅心，在清欢中，从容幽静，自在安然。一直向往走进青的山，碧的水，体悟山水的绚丽多姿，领略草木的兴衰荣枯，倾听黄天厚土之声，探寻宇宙自然的妙趣。走进了山水，也就走出了喧嚣，给身心以清凉，给精神以沉淀，给灵魂以升华。"];
            [_testContentArrayM addObject:@"Bill Gates is a very rich man today... and do you want 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝，与慈悲淡然的佛境禅心，在清欢中，从容幽静，自在安然。一直向往走进青的山，碧的水，体悟山水的绚丽多姿，领略草木的兴衰荣枯，倾听黄天厚土之声，探寻宇宙自然的妙趣。走进了山水，也就走出了喧嚣，给身心以清凉，给精神以沉淀，给灵魂以升华。"];
            [_testContentArrayM addObject:@"At 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，"];
            [_testContentArrayM addObject:@"It is curious that physical courage should be 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝，与慈悲淡然的佛境禅心，在清欢中，"];
            [_testContentArrayM addObject:@"The knowledge of the world is only to be acquired in the world, 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝，与慈悲淡然的佛境禅心，"];
            [_testContentArrayM addObject:@"What lies behind us and what lies before us are tiny 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝，与慈悲淡然的佛境禅心，在清欢中，"];
        }
        
        // 【随机练习题库】
        if ([self.testVCName isEqualToString:@"BAPageViewController_randomPracticeBtn"])
        {
            [_testContentArrayM addObject:@"【随机练习题库】仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝"];
            [_testContentArrayM addObject:@"When I am abroad, I always make it a rule never to 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。"];
            [_testContentArrayM addObject:@"After two years in Washington, I often long 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋"];
            [_testContentArrayM addObject:@"Bill Gates is a very rich man today... and do you want 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝，与慈悲淡然的佛境禅心，在清欢中，从容幽静，自在安然。一直向往走进青的山，碧的水，体悟山水的绚丽多姿，领略草木的兴衰荣枯，倾听黄天厚土之声，探寻宇宙自然的妙趣。走进了山水，也就走出了喧嚣，给身心以清凉，给精神以沉淀，给灵魂以升华。"];
            [_testContentArrayM addObject:@"At 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，"];
            [_testContentArrayM addObject:@"It is curious that physical courage should be 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝，与慈悲淡然的佛境禅心，在清欢中，"];
        }

        // 【模拟考试——全真模拟考试题库】
        if ([self.testVCName isEqualToString:@"BASimulationTestView_simulationTestBtn"])
        {
            [_testContentArrayM addObject:@"【模拟考试——全真模拟考试题库】仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝"];
            [_testContentArrayM addObject:@"When I am abroad, I always make it a rule never to 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。"];
            [_testContentArrayM addObject:@"After two years in Washington, I often long 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋"];
            [_testContentArrayM addObject:@"It is a profitable thing, if one is wise, to 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝，与慈悲淡然的佛境禅心，在清欢中，从容幽静，自在安然。一直向往走进青的山，碧的水，体悟山水的绚丽多姿，领略草木的兴衰荣枯，倾听黄天厚土之声，探寻宇宙自然的妙趣。走进了山水，也就走出了喧嚣，给身心以清凉，给精神以沉淀，给灵魂以升华。"];
            [_testContentArrayM addObject:@"Bill Gates is a very rich man today... and do you want 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝，与慈悲淡然的佛境禅心，在清欢中，从容幽静，自在安然。一直向往走进青的山，碧的水，体悟山水的绚丽多姿，领略草木的兴衰荣枯，倾听黄天厚土之声，探寻宇宙自然的妙趣。走进了山水，也就走出了喧嚣，给身心以清凉，给精神以沉淀，给灵魂以升华。"];
            [_testContentArrayM addObject:@"At 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，"];
            [_testContentArrayM addObject:@"It is curious that physical courage should be 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝，与慈悲淡然的佛境禅心，在清欢中，"];
            [_testContentArrayM addObject:@"The knowledge of the world is only to be acquired in the world, 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝，与慈悲淡然的佛境禅心，"];
            [_testContentArrayM addObject:@"What lies behind us and what lies before us are tiny 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝，与慈悲淡然的佛境禅心，在清欢中，"];
            [_testContentArrayM addObject:@"Whd us and what lies before us are tiny 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝，与慈悲淡然的佛境禅心，在清欢中，"];
            [_testContentArrayM addObject:@" behind us and what lies before us are tiny 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝，与慈悲淡然的佛境禅心，在清欢中，"];
        }
        
        // 【模拟考试——优先考未做题题库】
        if ([self.testVCName isEqualToString:@"BASimulationTestView_priorityTestBtn"])
        {
            [_testContentArrayM addObject:@"【模拟考试——优先考未做题题库】仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝"];
            [_testContentArrayM addObject:@"When I am abroad, I always make it a rule never to 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。"];
            [_testContentArrayM addObject:@"After two years in Washington, I often long 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋"];
            [_testContentArrayM addObject:@"It is a profitable thing, if one is wise, to 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝，与慈悲淡然的佛境禅心，在清欢中，从容幽静，自在安然。一直向往走进青的山，碧的水，体悟山水的绚丽多姿，领略草木的兴衰荣枯，倾听黄天厚土之声，探寻宇宙自然的妙趣。走进了山水，也就走出了喧嚣，给身心以清凉，给精神以沉淀，给灵魂以升华。"];
            [_testContentArrayM addObject:@"Bill Gates is a very rich man today... and do you want 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝，与慈悲淡然的佛境禅心，在清欢中，从容幽静，自在安然。一直向往走进青的山，碧的水，体悟山水的绚丽多姿，领略草木的兴衰荣枯，倾听黄天厚土之声，探寻宇宙自然的妙趣。走进了山水，也就走出了喧嚣，给身心以清凉，给精神以沉淀，给灵魂以升华。"];
            [_testContentArrayM addObject:@"At 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，"];
            [_testContentArrayM addObject:@"It is curious that physical courage should be 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝，与慈悲淡然的佛境禅心，在清欢中，"];
        }
        
        // 【难题攻克题库】
        if ([self.testVCName isEqualToString:@"BAPageViewController_overcomeBtn"])
        {
            [_testContentArrayM addObject:@"【难题攻克题库】仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝"];
            [_testContentArrayM addObject:@"When I am abroad, I always make it a rule never to 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。"];
            [_testContentArrayM addObject:@"After two years in Washington, I often long 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋"];
            [_testContentArrayM addObject:@"It is a profitable thing, if one is wise, to 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝，与慈悲淡然的佛境禅心，在清欢中，从容幽静，自在安然。一直向往走进青的山，碧的水，体悟山水的绚丽多姿，领略草木的兴衰荣枯，倾听黄天厚土之声，探寻宇宙自然的妙趣。走进了山水，也就走出了喧嚣，给身心以清凉，给精神以沉淀，给灵魂以升华。"];
            [_testContentArrayM addObject:@"Bill Gates is a very rich man today... and do you want 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝，与慈悲淡然的佛境禅心，在清欢中，从容幽静，自在安然。一直向往走进青的山，碧的水，体悟山水的绚丽多姿，领略草木的兴衰荣枯，倾听黄天厚土之声，探寻宇宙自然的妙趣。走进了山水，也就走出了喧嚣，给身心以清凉，给精神以沉淀，给灵魂以升华。"];
            [_testContentArrayM addObject:@"At 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，"];
            [_testContentArrayM addObject:@"It is curious that physical courage should be 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝，与慈悲淡然的佛境禅心，在清欢中，"];
        }
        
        // 【易错题集题库】
        if ([self.testVCName isEqualToString:@"BAPageViewController_easyWrongSetBtn"])
        {
            [_testContentArrayM addObject:@"【易错题集题库】仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝"];
            [_testContentArrayM addObject:@"When I am abroad, I always make it a rule never to 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。"];
            [_testContentArrayM addObject:@"After two years in Washington, I often long 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋"];
            [_testContentArrayM addObject:@"It is a profitable thing, if one is wise, to 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝，与慈悲淡然的佛境禅心，在清欢中，从容幽静，自在安然。一直向往走进青的山，碧的水，体悟山水的绚丽多姿，领略草木的兴衰荣枯，倾听黄天厚土之声，探寻宇宙自然的妙趣。走进了山水，也就走出了喧嚣，给身心以清凉，给精神以沉淀，给灵魂以升华。"];
            [_testContentArrayM addObject:@"Bill Gates is a very rich man today... and do you want 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝，与慈悲淡然的佛境禅心，在清欢中，从容幽静，自在安然。一直向往走进青的山，碧的水，体悟山水的绚丽多姿，领略草木的兴衰荣枯，倾听黄天厚土之声，探寻宇宙自然的妙趣。走进了山水，也就走出了喧嚣，给身心以清凉，给精神以沉淀，给灵魂以升华。"];
            [_testContentArrayM addObject:@"At 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，"];
            [_testContentArrayM addObject:@"It is curious that physical courage should be 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝，与慈悲淡然的佛境禅心，在清欢中，"];
        }
        
        // 【专项练习题库】
        if ([self.testVCName isEqualToString:@"BASpecialPracticeView"])
        {
            [_testContentArrayM addObject:@"【专项练习题库】仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝"];
            [_testContentArrayM addObject:@"When I am abroad, I always make it a rule never to 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。"];
            [_testContentArrayM addObject:@"After two years in Washington, I often long 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋"];
            [_testContentArrayM addObject:@"It is a profitable thing, if one is wise, to 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝，与慈悲淡然的佛境禅心，在清欢中，从容幽静，自在安然。一直向往走进青的山，碧的水，体悟山水的绚丽多姿，领略草木的兴衰荣枯，倾听黄天厚土之声，探寻宇宙自然的妙趣。走进了山水，也就走出了喧嚣，给身心以清凉，给精神以沉淀，给灵魂以升华。"];
            [_testContentArrayM addObject:@"Bill Gates is a very rich man today... and do you want 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝，与慈悲淡然的佛境禅心，在清欢中，从容幽静，自在安然。一直向往走进青的山，碧的水，体悟山水的绚丽多姿，领略草木的兴衰荣枯，倾听黄天厚土之声，探寻宇宙自然的妙趣。走进了山水，也就走出了喧嚣，给身心以清凉，给精神以沉淀，给灵魂以升华。"];
            [_testContentArrayM addObject:@"At 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，"];
            [_testContentArrayM addObject:@"It is curious that physical courage should be 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝，与慈悲淡然的佛境禅心，在清欢中，"];
        }
        
        // 【我的错题题库】
        if ([self.testVCName isEqualToString:@"BAWrongTestViewController"])
        {
            [_testContentArrayM addObject:@"【我的错题题库】仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝"];
            [_testContentArrayM addObject:@"When I am abroad, I always make it a rule never to 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。"];
            [_testContentArrayM addObject:@"After two years in Washington, I often long 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋"];
            [_testContentArrayM addObject:@"It is a profitable thing, if one is wise, to 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝，与慈悲淡然的佛境禅心，在清欢中，从容幽静，自在安然。一直向往走进青的山，碧的水，体悟山水的绚丽多姿，领略草木的兴衰荣枯，倾听黄天厚土之声，探寻宇宙自然的妙趣。走进了山水，也就走出了喧嚣，给身心以清凉，给精神以沉淀，给灵魂以升华。"];
            [_testContentArrayM addObject:@"At 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，"];
            [_testContentArrayM addObject:@"It is curious that physical courage should be 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝，与慈悲淡然的佛境禅心，在清欢中，"];
        }
        
        // 【我的收藏题库】
        if ([self.testVCName isEqualToString:@"BAMyCollectionViewController"])
        {
            [_testContentArrayM addObject:@"【我的收藏题库】仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝"];
            [_testContentArrayM addObject:@"When I am abroad, I always make it a rule never to 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。"];
            [_testContentArrayM addObject:@"It is a profitable thing, if one is wise, to 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝，与慈悲淡然的佛境禅心，在清欢中，从容幽静，自在安然。一直向往走进青的山，碧的水，体悟山水的绚丽多姿，领略草木的兴衰荣枯，倾听黄天厚土之声，探寻宇宙自然的妙趣。走进了山水，也就走出了喧嚣，给身心以清凉，给精神以沉淀，给灵魂以升华。"];
            [_testContentArrayM addObject:@"At 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，"];
            [_testContentArrayM addObject:@"It is curious that physical courage should be 日落时分，沏上一杯山茶，听一曲意境空远的《禅》，心神随此天籁，沉溺于玄妙的幻境里。仿佛我就是那穿梭于葳蕤山林中的一只飞鸟，时而盘旋穿梭，时而引吭高歌；仿佛我就是那潺潺流泻于山涧的一汪清泉，涟漪轻盈，浩淼长流；仿佛我就是那竦峙在天地间的一座山峦，伟岸高耸，从容绵延。我不相信佛，只是喜欢玄冥空灵的梵音经贝，与慈悲淡然的佛境禅心，在清欢中，"];
        }
    }
    return _testContentArrayM;
}

// 问题图片
- (NSArray *)testImageArray
{
    if (!_testImageArray)
    {
        _testImageArray = @[@"美食摄影(156图)_@树嶌收集_花瓣美食7",@"tea",@"",@"user copy",@"",@"美食摄影(156图)_@树嶌收集_花瓣美食8",@"",@"美食摄影(156图)_@树嶌收集_花瓣美食9",@""];
    }
    return _testImageArray;
}

- (NSMutableArray *)pageContentArrayM
{
    if (!_pageContentArrayM)
    {
        _pageContentArrayM = [NSMutableArray array];
    }
    return _pageContentArrayM;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self setUpNavi];
    [self createContentPages];// 初始化所有数据
    
    // 设置UIPageViewController的配置项
    NSDictionary *options =[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin]forKey:UIPageViewControllerOptionSpineLocationKey];
    
    // 实例化UIPageViewController对象，根据给定的属性
    self.pageController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options: options];
    
    // 设置UIPageViewController对象的代理
    _pageController.dataSource = self;
    _pageController.delegate = self;
    
    // 定义“这本书”的尺寸
    [[_pageController view] setFrame:CGRectMake(0, 64, KSCREEN_WIDTH, KSCREEN_HEIGHT - 64)];
    // 让UIPageViewController对象，显示相应的页数据。
    // UIPageViewController对象要显示的页数据封装成为一个NSArray。
    // 因为我们定义UIPageViewController对象显示样式为显示一页（options参数指定）。
    // 如果要显示2页，NSArray中，应该有2个相应页数据。
    
    BAScrollPageViewController *initialViewController =[self viewControllerAtIndex:0];//得到第一页
    NSArray *viewControllers =[NSArray arrayWithObject:initialViewController];
    
    [_pageController setViewControllers:viewControllers direction: UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // 在页面上，显示UIPageViewController对象的View
    [self addChildViewController:_pageController];
    [[self view] addSubview:[_pageController view]];
//    [self setPageController:[self viewControllerAtIndex:5]];
}

#pragma mark - navi
- (void)setUpNavi
{
    UIView *naviView = [[UIView alloc] init];
    naviView.frame = CGRectMake(60, 20, KSCREEN_WIDTH - 60, 44);
    
    // 【模拟考试-全真模拟考试】
    // 【模拟考试-优先考未做题】
    if ([self.testVCName isEqualToString:@"BASimulationTestView_simulationTestBtn"] || [self.testVCName isEqualToString:@"BASimulationTestView_priorityTestBtn"])
    {
        // 倒计时
        // navi按钮 - 时间 45：00
        CGRect timeBtnFrame = CGRectMake(KSCREEN_WIDTH - 50*3 - 20*3, 0, 50, 44);
        self.timeBtn = [[BAButton alloc] custonmButtonWithFrame:timeBtnFrame title:@"45:00" state:UIControlStateNormal backgroundColor:[UIColor clearColor]];
        [self.timeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.timeBtn addTarget:self action:@selector(timeBtnClick:) forControlEvents:UIControlEventTouchUpInside];

        __block int timeout = 2700; //倒计时时间
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if(timeout<=0){ //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
//                    [self.timeBtn setTitle:[NSString stringWithFormat:@"%02d:%02d", min, sec] forState:UIControlStateNormal];
                    [[[UIAlertView alloc] initWithTitle:nil message:@"考试时间到了，请交卷！" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                });
            }else{
                int minutes = timeout / 60;
                int seconds = timeout % 60;
                NSString *strTime = [NSString stringWithFormat:@"%d:%.2d",minutes, seconds];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    [self.timeBtn setTitle:strTime forState:UIControlStateNormal];
                });
                timeout--;
            }
        });
        dispatch_resume(_timer);
        
        // navi按钮 - 考题数量
        CGRect testNumberBtnFrame = CGRectMake(KSCREEN_WIDTH - 50*2- 20*2, 0, 70, 44);
        self.testNumberBtn = [[BAButton alloc] custonmButtonWithFrame:testNumberBtnFrame title:@"1/100" state:UIControlStateNormal backgroundColor:[UIColor clearColor]];
        [self.testNumberBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.testNumberBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.testNumberBtn addTarget:self action:@selector(testNumberBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.testNumberBtn.selected = NO;
        
        // navi按钮 - 分享
        CGRect shareBtnFrame = CGRectMake(KSCREEN_WIDTH - 50 - 20*2, 0, 50, 44);
        self.shareBtn = [[BAButton alloc] custonmButtonWithFrame:shareBtnFrame title:nil state:UIControlStateNormal backgroundColor:[UIColor clearColor]];
        [self.shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
        [self.shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [naviView addSubview:self.timeBtn];
        [naviView addSubview:self.testNumberBtn];
        [naviView addSubview:self.shareBtn];
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:naviView];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    else
    {
        // navi按钮 - 考题数量
        CGRect testNumberBtnFrame = CGRectMake(KSCREEN_WIDTH - 50*3 - 20*3, 0, 70, 44);
        self.testNumberBtn = [[BAButton alloc] custonmButtonWithFrame:testNumberBtnFrame title:@"1/10" state:UIControlStateNormal backgroundColor:[UIColor clearColor]];
        [self.testNumberBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.testNumberBtn addTarget:self action:@selector(testNumberBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.testNumberBtn.selected = NO;

        // navi按钮 - 收藏
        CGRect collectionBtnFrame = CGRectMake(KSCREEN_WIDTH - 50*2- 20*2, 0, 50, 44);
        self.collectionBtn = [[BAButton alloc] custonmButtonWithFrame:collectionBtnFrame title:nil state:UIControlStateNormal backgroundColor:[UIColor clearColor]];
        [self.collectionBtn setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
        [self.collectionBtn setImage:[UIImage imageNamed:@"yishoucang"] forState:UIControlStateSelected];
        [self.collectionBtn addTarget:self action:@selector(collectionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.collectionBtn.selected = NO;

        // navi按钮 - 分享
        CGRect shareBtnFrame = CGRectMake(KSCREEN_WIDTH - 50 - 20*2, 0, 50, 44);
        self.shareBtn = [[BAButton alloc] custonmButtonWithFrame:shareBtnFrame title:nil state:UIControlStateNormal backgroundColor:[UIColor clearColor]];
        [self.shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
        [self.shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [naviView addSubview:self.testNumberBtn];
        [naviView addSubview:self.collectionBtn];
        [naviView addSubview:self.shareBtn];
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:naviView];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
}

#pragma mark - 初始化所有数据
- (void)createContentPages
{
    for (int i = 1; i<= self.testContentArrayM.count; i++)
    {
        NSString *testContentStr = [self.testContentArrayM objectAtIndex:(i-1)];
        [self.pageContentArrayM addObject:testContentStr];
    }
}

// 得到相应的VC对象
- (BAScrollPageViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageContentArrayM count] == 0) || (index > [self.pageContentArrayM count]))
    {
        return nil;
    }
    // 创建一个新的控制器类，并且分配给相应的数据
    BAScrollPageViewController *dataVC =[[BAScrollPageViewController alloc] init];
    dataVC.testContenDetailStr = [self.pageContentArrayM objectAtIndex:index];
    int dataRandomIndex = arc4random_uniform(self.pageContentArrayM.count);
    dataVC.testImageNameStr = [self.testImageArray objectAtIndex:dataRandomIndex];
    dataVC.pageIndex = index + 1;
    dataVC.delegate = self;

    return dataVC;
}

// 根据数组元素值，得到下标值
- (NSUInteger)indexOfViewController:(BAScrollPageViewController *)viewController {
//    return [self.pageContentArrayM indexOfObject:viewController.pageIndex];
    return [self.pageContentArrayM indexOfObject:viewController.testContenDetailStr];
}

#pragma mark- UIPageViewControllerDataSource
// 返回上一个ViewController对象

- (UIViewController *)pageViewController:(UIPageViewController*)pageViewController viewControllerBeforeViewController:(UIViewController*)viewController{
    NSUInteger index = [self indexOfViewController:(BAScrollPageViewController *)viewController];

    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    
    // 返回的ViewController，将被添加到相应的UIPageViewController对象上。
    // UIPageViewController对象会根据UIPageViewControllerDataSource协议方法，自动来维护次序。
    // 不用我们去操心每个ViewController的顺序问题。
//    NSLog(@"%ld--" ,index);

    return [self viewControllerAtIndex:index];
}

// 返回下一个ViewController对象
- (UIViewController *)pageViewController:(UIPageViewController*)pageViewController viewControllerAfterViewController:(UIViewController*)viewController{
    
    NSUInteger index = [self indexOfViewController:(BAScrollPageViewController *)viewController];

    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [self.pageContentArrayM count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

// delegate
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
//    NSUInteger index = [self indexOfViewController:(BAScrollPageViewController *)pageViewController];
//    NSLog(@"%lu ==== ", (unsigned long)index);

}

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    // 无论有无翻页，只要动画结束就恢复交互。
    if (finished){
        pageViewController.view.userInteractionEnabled = YES;
    }
}

#pragma mark - BAScrollPageViewDelegate
-(void)reloadTitleWithPage:(NSInteger)page
{
    NSLog(@"第%ld题", (long)page);
    [self.testNumberBtn setTitle:[NSString stringWithFormat:@"%ld/%lu",(long)page,(unsigned long)self.pageContentArrayM.count] forState:UIControlStateNormal ];
}

#pragma mark - 按钮点击事件
#pragma mark navi按钮 - 题目总数
- (IBAction)testNumberBtnClick:(id)sender
{
    self.testNumberBtn.selected = !self.testNumberBtn.selected;

    if (self.testNumberBtn.selected)
    {
        CGRect bottomViewFrame = CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - 64);
        self.bottomView = [[UIView alloc] init];
        self.bottomView.frame = bottomViewFrame;
        self.bottomView.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:self.bottomView];
        
        CGRect questionBankViewFrame = CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT - 64);
        BAQuestionBankView *questionBankView = [[BAQuestionBankView alloc] initWithSize:questionBankViewFrame.size at:self.bottomView];
        questionBankView.testDataArray = self.pageContentArrayM;
        [questionBankView selected:^(NSIndexPath *indexPath, UICollectionView *collectionView, UICollectionViewCell *cell){
            
        }];
    }
    else
    {
        self.bottomView.hidden = YES;
    }
    
}

#pragma mark navi按钮 - 时间
- (IBAction)timeBtnClick:(id)sender
{

}
#pragma mark navi按钮 - 收藏
- (IBAction)collectionBtnClick:(id)sender
{
    self.collectionBtn.selected = !self.collectionBtn.selected;
}

#pragma mark navi按钮 - 分享
- (IBAction)shareBtnClick:(id)sender
{
    [[[UIAlertView alloc] initWithTitle:nil message:@"暂时未开通此功能！" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}



@end
