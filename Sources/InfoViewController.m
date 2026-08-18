#import "InfoViewController.h"

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];

    UILabel *texto = [[UILabel alloc] init];
    texto.text = @"¿Sabías qué? es una aplicación móvil que permite a los usuarios descubrir datos curiosos sobre distintos temas de su interés, como cultura general, cine, videojuegos y entretenimiento. A través de una acción sencilla (seleccionar una categoría y tocar un botón), la app genera datos breves y entretenidos, ideales para consultar en momentos libres del día.";
    texto.numberOfLines = 0;
    texto.font = [UIFont systemFontOfSize:15];
    texto.textColor = [UIColor systemPurpleColor];
    texto.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:texto];

    UIButton *botonCerrar = [UIButton buttonWithType:UIButtonTypeSystem];
    UIImageSymbolConfiguration *config = [UIImageSymbolConfiguration configurationWithPointSize:22 weight:UIImageSymbolWeightRegular];
    [botonCerrar setImage:[[UIImage systemImageNamed:@"xmark.circle"] imageByApplyingSymbolConfiguration:config] forState:UIControlStateNormal];
    botonCerrar.tintColor = [UIColor systemPurpleColor];
    botonCerrar.accessibilityIdentifier = @"botonCerrarInfo";
    botonCerrar.translatesAutoresizingMaskIntoConstraints = NO;
    [botonCerrar addTarget:self action:@selector(cerrar) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:botonCerrar];

    UILayoutGuide *guide = self.view.safeAreaLayoutGuide;
    [NSLayoutConstraint activateConstraints:@[
        [botonCerrar.topAnchor constraintEqualToAnchor:guide.topAnchor constant:16],
        [botonCerrar.trailingAnchor constraintEqualToAnchor:guide.trailingAnchor constant:-20],

        [texto.topAnchor constraintEqualToAnchor:botonCerrar.bottomAnchor constant:24],
        [texto.leadingAnchor constraintEqualToAnchor:guide.leadingAnchor constant:24],
        [texto.trailingAnchor constraintEqualToAnchor:guide.trailingAnchor constant:-24],
    ]];
}

- (void)cerrar {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
