#import "InicioViewController.h"
#import "InfoViewController.h"
#import "ViewController.h"

@implementation InicioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.navigationController.navigationBarHidden = YES;

    // Círculo de fondo del logo
    UIView *circulo = [[UIView alloc] init];
    circulo.backgroundColor = [UIColor colorWithRed:0.16 green:0.09 blue:0.28 alpha:1.0];
    circulo.layer.cornerRadius = 56;
    circulo.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:circulo];

    // Ícono del logo
    UIImageView *icono = [[UIImageView alloc] init];
    UIImageSymbolConfiguration *configIcono = [UIImageSymbolConfiguration configurationWithPointSize:44 weight:UIImageSymbolWeightRegular];
    icono.image = [[UIImage systemImageNamed:@"brain.head.profile"] imageByApplyingSymbolConfiguration:configIcono];
    icono.tintColor = [UIColor systemPurpleColor];
    icono.contentMode = UIViewContentModeScaleAspectFit;
    icono.translatesAutoresizingMaskIntoConstraints = NO;
    [circulo addSubview:icono];

    // Título
    UILabel *titulo = [[UILabel alloc] init];
    titulo.text = @"¿Sabías qué?";
    titulo.font = [UIFont boldSystemFontOfSize:26];
    titulo.textColor = [UIColor systemPurpleColor];
    titulo.textAlignment = NSTextAlignmentCenter;
    titulo.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:titulo];

    // Botón "Comenzar"
    UIButton *botonComenzar = [UIButton buttonWithType:UIButtonTypeSystem];
    [botonComenzar setTitle:@"COMENZAR" forState:UIControlStateNormal];
    botonComenzar.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [botonComenzar setTitleColor:[UIColor systemPurpleColor] forState:UIControlStateNormal];
    botonComenzar.layer.borderColor = [UIColor systemPurpleColor].CGColor;
    botonComenzar.layer.borderWidth = 1.5;
    botonComenzar.layer.cornerRadius = 6;
    botonComenzar.accessibilityIdentifier = @"botonComenzar";
    botonComenzar.translatesAutoresizingMaskIntoConstraints = NO;
    [botonComenzar addTarget:self action:@selector(irACategorias) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:botonComenzar];

    // Botón de información (ícono "i")
    UIButton *botonInfo = [UIButton buttonWithType:UIButtonTypeSystem];
    UIImageSymbolConfiguration *configInfo = [UIImageSymbolConfiguration configurationWithPointSize:22 weight:UIImageSymbolWeightRegular];
    [botonInfo setImage:[[UIImage systemImageNamed:@"info.circle"] imageByApplyingSymbolConfiguration:configInfo] forState:UIControlStateNormal];
    botonInfo.tintColor = [UIColor systemPurpleColor];
    botonInfo.accessibilityIdentifier = @"botonInfo";
    botonInfo.translatesAutoresizingMaskIntoConstraints = NO;
    [botonInfo addTarget:self action:@selector(mostrarInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:botonInfo];

    UILayoutGuide *guide = self.view.safeAreaLayoutGuide;

    [NSLayoutConstraint activateConstraints:@[
        [botonInfo.topAnchor constraintEqualToAnchor:guide.topAnchor constant:16],
        [botonInfo.trailingAnchor constraintEqualToAnchor:guide.trailingAnchor constant:-20],

        [circulo.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [circulo.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-60],
        [circulo.widthAnchor constraintEqualToConstant:112],
        [circulo.heightAnchor constraintEqualToConstant:112],

        [icono.centerXAnchor constraintEqualToAnchor:circulo.centerXAnchor],
        [icono.centerYAnchor constraintEqualToAnchor:circulo.centerYAnchor],

        [titulo.topAnchor constraintEqualToAnchor:circulo.bottomAnchor constant:20],
        [titulo.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],

        [botonComenzar.topAnchor constraintEqualToAnchor:titulo.bottomAnchor constant:16],
        [botonComenzar.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [botonComenzar.widthAnchor constraintGreaterThanOrEqualToConstant:110],
        [botonComenzar.heightAnchor constraintEqualToConstant:36],
    ]];
}

- (void)irACategorias {
    ViewController *categorias = [[ViewController alloc] init];
    categorias.title = @"Categorías";
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:categorias animated:YES];
}

- (void)mostrarInfo {
    InfoViewController *info = [[InfoViewController alloc] init];
    info.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:info animated:YES completion:nil];
}

@end
