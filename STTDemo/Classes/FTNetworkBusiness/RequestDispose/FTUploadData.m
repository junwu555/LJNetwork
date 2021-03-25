//
//  FTUploadData.m
//  RiceBall
//
//  Created by QMY on 2021/3/10.
//

#import "FTUploadData.h"
@interface FTUploadData()
@property (nonatomic ,strong)NSMutableArray<FTHttpUploadConfig *> * array;
@end
@implementation FTUploadData

-(NSMutableArray<FTHttpUploadConfig *> *)array
{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

- (void)insert:(FTHttpUploadConfig *)config
{
    [self.array addObject:config];
}

- (nonnull NSArray<FTHttpUploadConfig *> *)getUploadConfig
{
    return [_array copy];
}
@end


