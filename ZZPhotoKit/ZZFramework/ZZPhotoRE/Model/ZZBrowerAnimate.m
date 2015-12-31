//
//  ZZBrowerAnimate.m
//  ZZFramework
//
//  Created by Yuan on 15/12/28.
//  Copyright © 2015年 zzl. All rights reserved.
//

#import "ZZBrowerAnimate.h"

@implementation ZZBrowerAnimate

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.style == PushAnimate) {
        
        UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        
        UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        
        // Get the container view - where the animation has to happen
        toVC.view.frame = CGRectMake(0 - toVC.view.frame.size.width, toVC.view.frame.size.height, toVC.view.frame.size.width, toVC.view.frame.size.height);
        UIView *containerView = [transitionContext containerView];
        
        // Add the two VC views to the container. Hide the to
        [containerView addSubview:fromVC.view];
        [containerView addSubview:toVC.view];
        toVC.view.alpha = 0.0;
        
        // Perform the animation
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            toVC.view.alpha = 1.0;
            toVC.view.frame = CGRectMake(0, 0, toVC.view.frame.size.width, toVC.view.frame.size.height);
        } completion:^(BOOL finished) {
            // Let's get rid of the old VC view
            [fromVC.view removeFromSuperview];
            // And then we need to tell the context that we're done
            [transitionContext completeTransition:YES];
            
        }];
        
        
    }else if (self.style == ZZBrowerAnimateStyleOfBoxCenter){
    
        UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        [[transitionContext containerView] addSubview:toViewController.view];
        toViewController.view.alpha = 0;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromViewController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
            toViewController.view.alpha = 1;
        } completion:^(BOOL finished) {
            fromViewController.view.transform = CGAffineTransformIdentity;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            
        }];
    }else if (self.style == ZZBrowerAnimateStyleOfBoxLeft){
        
        UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        [[transitionContext containerView] addSubview:toViewController.view];
        toViewController.view.alpha = 0;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromViewController.view.transform = CGAffineTransformTranslate(fromViewController.view.transform, 200, 200);
            toViewController.view.alpha = 1;
        } completion:^(BOOL finished) {
            fromViewController.view.transform = CGAffineTransformIdentity;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            
        }];
        
    }
}

@end
