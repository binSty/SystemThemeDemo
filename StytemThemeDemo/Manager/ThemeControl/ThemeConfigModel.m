//
//  ThemeConfigModel.m
//  StytemThemeDemo
//
//  Created by YD_Dev_BinY on 2022/1/25.
//

#import "ThemeConfigModel.h"
#import "UIColor+ThemeColor.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface ThemeConfigModel ()

@property (nonatomic, copy) void(^modelUpdateCurrentThemeConfig)(void);
@property (nonatomic, copy) void(^modelConfigThemeChangingBlock)(void);

@property (nonatomic, copy) ThemeChangingBlock modelChangingBlock;

@property (nonatomic, copy) NSString *modelCurrentThemeTag;

@property (nonatomic, strong) NSMutableDictionary <NSString * , NSMutableDictionary *>*modelThemeBlockConfigInfo; // @{tag : @{block : value}}
@property (nonatomic, strong) NSMutableDictionary <NSString * , NSMutableDictionary *>*modelThemeKeyPathConfigInfo; // @{keypath : @{tag : value}}
@property (nonatomic, strong) NSMutableDictionary <NSString * , NSMutableDictionary *>*modelThemeSelectorConfigInfo; // @{selector : @{tag : @[@[parameter, parameter,...] , @[...]]}}

@end

@implementation ThemeConfigModel

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    objc_removeAssociatedObjects(self);
    
    _modelCurrentThemeTag = nil;
    _modelThemeBlockConfigInfo = nil;
    _modelThemeKeyPathConfigInfo = nil;
    _modelThemeSelectorConfigInfo = nil;
}

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)updateCurrentThemeConfigHandleWithTag:(NSString *)tag{
    if ([[ThemeColorManager currentThemeTag] isEqualToString:tag]) {
        if ([NSThread isMainThread]) {
            if (self.modelUpdateCurrentThemeConfig) {
                self.modelUpdateCurrentThemeConfig();
            }
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.modelUpdateCurrentThemeConfig) {
                    self.modelUpdateCurrentThemeConfig();
                }
            });
        }
    }
}

- (ConfigThemeToChangingBlock)LeeThemeChangingBlock {
    __weak typeof(self) weakSelf = self;
    
    return ^(ThemeChangingBlock changingBlock){
        
        if (changingBlock) {
            
            weakSelf.modelChangingBlock = changingBlock;
            if (weakSelf.modelConfigThemeChangingBlock) weakSelf.modelConfigThemeChangingBlock();
        }
        return weakSelf;
    };
}

- (ConfigThemeToT_Color)leeAddBackgroundColor {
    __weak typeof(self) weakSelf = self;
    return ^(NSString *tag, id color) {
        return weakSelf.LeeAddSelectorAndColor(tag, @selector(setBackgroundColor:), color);
    };
}

- (ConfigThemeToT_Image)LeeAddImage {
    __weak typeof(self) weakSelf = self;
    return ^(NSString *tag, id image){
        return weakSelf.LeeAddSelectorAndImage(tag , @selector(setImage:) , image);
    };
}

- (ConfigThemeToT_ImageAndState)LeeAddButtonImage {
    __weak typeof(self) weakSelf = self;
    return ^(NSString *tag , UIImage *image , UIControlState state){
        return weakSelf.LeeAddSelectorAndValues(tag , @selector(setImage:forState:) , image , @(state), nil);
    };
}

- (ConfigThemeToT_Color)LeeAddSeparatorColor {
    __weak typeof(self) weakSelf = self;
    return ^(NSString *tag , id color){
        return weakSelf.LeeAddSelectorAndColor(tag , @selector(setSeparatorColor:) , color);
    };
}

- (ConfigThemeToT_Color)LeeAddTextColor {
    __weak typeof(self) weakSelf = self;
    return ^(NSString *tag , id color){
        return weakSelf.LeeAddSelectorAndColor(tag , @selector(setTextColor:) , color);
    };
}

- (ConfigThemeToT_SelectorAndColor)LeeAddSelectorAndColor {
    __weak typeof(self) weakSelf = self;
    return ^(NSString *tag, SEL sel, id color) {
        id value = nil;
        if ([color isKindOfClass:NSString.class]) {
            value = [UIColor leeTheme_ColorWithHexString:color];
        } else {
            value = color;
        }
        if (value) weakSelf.LeeAddSelectorAndValueArray(tag , sel , @[value]);
        return weakSelf;
    };
}

- (ConfigThemeToT_Image)LeeAddShadowImage {
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag , id image){
        return weakSelf.LeeAddSelectorAndImage(tag , @selector(setShadowImage:) , image);
    };
}

- (ConfigThemeToT_SelectorAndImage)LeeAddSelectorAndImage {
    __weak typeof(self) weakSelf = self;
    return ^(NSString *tag, SEL sel, id image){
        id value = nil;
        if ([image isKindOfClass:NSString.class]) {
            value = [UIImage imageNamed:image];
            if (!value) value = [UIImage imageWithContentsOfFile:image];
        } else {
            value = image;
        }
        if (value) weakSelf.LeeAddSelectorAndValueArray(tag , sel , @[value]);
        return weakSelf;
    };
}

- (ConfigThemeToT_SelectorAndValues)LeeAddSelectorAndValues {
    __weak typeof(self) weakSelf = self;
    return ^(NSString *tag, SEL sel , ...){
        
        if (!sel) return weakSelf;
        
        NSMutableArray *array = [NSMutableArray array];
        
        va_list argsList;
        
        va_start(argsList, sel);
        
        id arg;
        
        while ((arg = va_arg(argsList, id))) {
            
            [array addObject:arg];
        }
        
        va_end(argsList);
        
        return weakSelf.LeeAddSelectorAndValueArray(tag, sel, array);
    };
}

- (ConfigThemeToT_SelectorAndValueArray)LeeAddSelectorAndValueArray {
    __weak typeof(self) weakSelf = self;
    
    return ^(NSString *tag, SEL sel , NSArray *values){
      
        if (!tag) return weakSelf;
        
        if (!sel) return weakSelf;
        
        NSString *key = NSStringFromSelector(sel);
        
        NSMutableDictionary *info = weakSelf.modelThemeSelectorConfigInfo[key];
        
        if (!info) info = [NSMutableDictionary dictionary];
        
        NSMutableArray *valuesArray = info[tag];
        
        if (!valuesArray) valuesArray = [NSMutableArray array];
        
        NSArray *temp = [valuesArray copy];
        
        [temp enumerateObjectsUsingBlock:^(NSArray *valueArray, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([valueArray isEqualToArray:values]) [valuesArray removeObject:valueArray]; // 过滤相同参数值的数组
        }];
        
        if (values && values.count) [valuesArray addObject:values];
        
        [info setObject:valuesArray forKey:tag];
        
        [weakSelf.modelThemeSelectorConfigInfo setObject:info forKey:key];
        
        [weakSelf updateCurrentThemeConfigHandleWithTag:tag];
        
        return weakSelf;
    };
}


#pragma mark - LazyLoading
- (NSMutableDictionary *)modelThemeBlockConfigInfo{
    if (!_modelThemeBlockConfigInfo) _modelThemeBlockConfigInfo = [NSMutableDictionary dictionary];
    
    return _modelThemeBlockConfigInfo;
}

- (NSMutableDictionary *)modelThemeKeyPathConfigInfo{
    if (!_modelThemeKeyPathConfigInfo) _modelThemeKeyPathConfigInfo = [NSMutableDictionary dictionary];

    return _modelThemeKeyPathConfigInfo;
}

- (NSMutableDictionary *)modelThemeSelectorConfigInfo{
    if (!_modelThemeSelectorConfigInfo) _modelThemeSelectorConfigInfo = [NSMutableDictionary dictionary];
    
    return _modelThemeSelectorConfigInfo;
}

@end

@implementation NSObject (ThemeConfigObject)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSArray *selStringsArray = @[@"dealloc"];
        [selStringsArray enumerateObjectsUsingBlock:^(NSString *selString, NSUInteger idx, BOOL *stop) {
            NSString *leeSelString = [@"lee_theme_" stringByAppendingString:selString];
            Method originalMethod = class_getInstanceMethod(self, NSSelectorFromString(selString));
            Method leeMethod = class_getInstanceMethod(self, NSSelectorFromString(leeSelString));
            BOOL isAddedMethod = class_addMethod(self, NSSelectorFromString(selString), method_getImplementation(leeMethod), method_getTypeEncoding(leeMethod));
            if (isAddedMethod) {
                class_replaceMethod(self, NSSelectorFromString(leeSelString), method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
            } else {
                method_exchangeImplementations(originalMethod, leeMethod);
            }
        }];
    });
}

- (void)lee_theme_dealloc{
    
    if ([self isLeeTheme]) {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:ThemeChangingNotificaiton object:nil];
        objc_removeAssociatedObjects(self);
    }

    [self lee_theme_dealloc];
}

- (BOOL)isChangeTheme{
    
    return (!self.lee_theme.modelCurrentThemeTag || ![self.lee_theme.modelCurrentThemeTag isEqualToString:[ThemeColorManager currentThemeTag]]) ? YES : NO;
}

- (void)leeTheme_ChangeThemeConfigNotify:(NSNotification *)notify{
    
    if ([self isChangeTheme]) {
        
        if (self.lee_theme.modelChangingBlock) self.lee_theme.modelChangingBlock([ThemeColorManager currentThemeTag] , self);
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        [self changeThemeConfig];
        [CATransaction commit];
    }
}

- (void)setInv:(NSInvocation *)inv Sig:(NSMethodSignature *)sig Obj:(id)obj Index:(NSInteger)index{
    
    if (sig.numberOfArguments <= index) return;
    
    char *type = (char *)[sig getArgumentTypeAtIndex:index];
    
    while (*type == 'r' || // const
           *type == 'n' || // in
           *type == 'N' || // inout
           *type == 'o' || // out
           *type == 'O' || // bycopy
           *type == 'R' || // byref
           *type == 'V') { // oneway
        type++; // cutoff useless prefix
    }
    
    BOOL unsupportedType = NO;
    
    switch (*type) {
        case 'v': // 1: void
        case 'B': // 1: bool
        case 'c': // 1: char / BOOL
        case 'C': // 1: unsigned char
        case 's': // 2: short
        case 'S': // 2: unsigned short
        case 'i': // 4: int / NSInteger(32bit)
        case 'I': // 4: unsigned int / NSUInteger(32bit)
        case 'l': // 4: long(32bit)
        case 'L': // 4: unsigned long(32bit)
        { // 'char' and 'short' will be promoted to 'int'.
            int value = [obj intValue];
            [inv setArgument:&value atIndex:index];
        } break;
            
        case 'q': // 8: long long / long(64bit) / NSInteger(64bit)
        case 'Q': // 8: unsigned long long / unsigned long(64bit) / NSUInteger(64bit)
        {
            long long value = [obj longLongValue];
            [inv setArgument:&value atIndex:index];
        } break;
            
        case 'f': // 4: float / CGFloat(32bit)
        { // 'float' will be promoted to 'double'.
            double value = [obj doubleValue];
            float valuef = value;
            [inv setArgument:&valuef atIndex:index];
        } break;
            
        case 'd': // 8: double / CGFloat(64bit)
        {
            double value = [obj doubleValue];
            [inv setArgument:&value atIndex:index];
        } break;
            
        case '*': // char *
        case '^': // pointer
        {
            if ([obj isKindOfClass:UIColor.class]) obj = (id)[obj CGColor]; //CGColor转换
            if ([obj isKindOfClass:UIImage.class]) obj = (id)[obj CGImage]; //CGImage转换
            void *value = (__bridge void *)obj;
            [inv setArgument:&value atIndex:index];
        } break;
            
        case '@': // id
        {
            id value = obj;
            [inv setArgument:&value atIndex:index];
        } break;
            
        case '{': // struct
        {
            if (strcmp(type, @encode(CGPoint)) == 0) {
                CGPoint value = [obj CGPointValue];
                [inv setArgument:&value atIndex:index];
            } else if (strcmp(type, @encode(CGSize)) == 0) {
                CGSize value = [obj CGSizeValue];
                [inv setArgument:&value atIndex:index];
            } else if (strcmp(type, @encode(CGRect)) == 0) {
                CGRect value = [obj CGRectValue];
                [inv setArgument:&value atIndex:index];
            } else if (strcmp(type, @encode(CGVector)) == 0) {
                CGVector value = [obj CGVectorValue];
                [inv setArgument:&value atIndex:index];
            } else if (strcmp(type, @encode(CGAffineTransform)) == 0) {
                CGAffineTransform value = [obj CGAffineTransformValue];
                [inv setArgument:&value atIndex:index];
            } else if (strcmp(type, @encode(CATransform3D)) == 0) {
                CATransform3D value = [obj CATransform3DValue];
                [inv setArgument:&value atIndex:index];
            } else if (strcmp(type, @encode(NSRange)) == 0) {
                NSRange value = [obj rangeValue];
                [inv setArgument:&value atIndex:index];
            } else if (strcmp(type, @encode(UIOffset)) == 0) {
                UIOffset value = [obj UIOffsetValue];
                [inv setArgument:&value atIndex:index];
            } else if (strcmp(type, @encode(UIEdgeInsets)) == 0) {
                UIEdgeInsets value = [obj UIEdgeInsetsValue];
                [inv setArgument:&value atIndex:index];
            } else {
                unsupportedType = YES;
            }
        } break;
            
        case '(': // union
        {
            unsupportedType = YES;
        } break;
            
        case '[': // array
        {
            unsupportedType = YES;
        } break;
            
        default: // what?!
        {
            unsupportedType = YES;
        } break;
    }
}

- (void)changeThemeConfig{
    
    self.lee_theme.modelCurrentThemeTag = [ThemeColorManager currentThemeTag];
    
    NSString *tag = [ThemeColorManager currentThemeTag];
    // Selector
    for (NSString *selector in self.lee_theme.modelThemeSelectorConfigInfo) {
        NSDictionary *info = self.lee_theme.modelThemeSelectorConfigInfo[selector];
        NSArray *valuesArray = info[tag];
        for (NSArray *values in valuesArray) {
            SEL sel = NSSelectorFromString(selector);
            NSMethodSignature * sig = [self methodSignatureForSelector:sel];
            if (!sig) [self doesNotRecognizeSelector:sel];
            NSInvocation *inv = [NSInvocation invocationWithMethodSignature:sig];
            if (!inv) [self doesNotRecognizeSelector:sel];
            
            [inv setTarget:self];
            
            [inv setSelector:sel];
            
            if (sig.numberOfArguments == values.count + 2) {
                
                [values enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSInteger index = idx + 2;
                    [self setInv:inv Sig:sig Obj:obj Index:index];
                }];
                [inv invoke];
            } else {
                NSAssert(YES, @"参数个数与方法参数个数不匹配");
            }
        }
    }
}

- (ThemeConfigModel *)lee_theme{
    
    ThemeConfigModel *model = objc_getAssociatedObject(self, _cmd);
    if (!model) {
        model = [ThemeConfigModel new];
        
        objc_setAssociatedObject(self, _cmd, model , OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(leeTheme_ChangeThemeConfigNotify:) name:ThemeChangingNotificaiton object:nil];
        
        [self setIsLeeTheme:YES];
        
        __weak typeof(self) weakSelf = self;
        model.modelUpdateCurrentThemeConfig = ^{
            if (weakSelf) [weakSelf changeThemeConfig];
        };
        
        model.modelConfigThemeChangingBlock = ^{
            if (weakSelf) weakSelf.lee_theme.modelChangingBlock([ThemeColorManager currentThemeTag], weakSelf);
        };
    }
    return model;
}

- (void)setLee_theme:(ThemeConfigModel *)lee_theme{
    
    if(self) objc_setAssociatedObject(self, @selector(lee_theme), lee_theme , OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isLeeTheme{
    
    return self ? [objc_getAssociatedObject(self, _cmd) boolValue] : NO;
}

- (void)setIsLeeTheme:(BOOL)isLeeTheme{
    
    if (self) objc_setAssociatedObject(self, @selector(isLeeTheme), @(isLeeTheme) , OBJC_ASSOCIATION_ASSIGN);
}


@end
