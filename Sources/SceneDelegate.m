#import "SceneDelegate.h"
#import "InicioViewController.h"

@interface SceneDelegate ()
@end

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene];

    InicioViewController *inicio = [[InicioViewController alloc] init];
    UINavigationController *navegacion = [[UINavigationController alloc] initWithRootViewController:inicio];

    self.window.rootViewController = navegacion;
    [self.window makeKeyAndVisible];
}

@end
