#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSDictionary<NSString *, NSArray<NSString *> *> *datosCuriosos;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSNumber *> *ultimoIndice;
@property (nonatomic, strong) NSString *categoriaSeleccionada;

@property (nonatomic, strong) UIButton *botonCulturaGeneral;
@property (nonatomic, strong) UIButton *botonCine;
@property (nonatomic, strong) UIButton *botonVideojuegos;
@property (nonatomic, strong) UILabel *categoriaLabel;
@property (nonatomic, strong) UILabel *datoLabel;
@property (nonatomic, strong) UIButton *botonNuevoDato;
@property (nonatomic, strong) UIButton *botonCompartir;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];

    self.datosCuriosos = @{
        @"Cultura general": @[
            @"Un grupo de búhos se llama parlamento.",
            @"La miel nunca se echa a perder: se ha encontrado miel comestible en tumbas egipcias de más de 3000 años.",
            @"El corazón de una ballena azul pesa aproximadamente lo mismo que un auto pequeño."
        ],
        @"Cine": @[
            @"La película ganadora del Óscar más corta dura menos de un minuto.",
            @"'Viaje a la Luna' (1902) fue una de las primeras películas en usar efectos especiales.",
            @"La saga de Star Wars fue rechazada por varios estudios antes de ser aceptada por 20th Century Fox."
        ],
        @"Videojuegos": @[
            @"El primer videojuego, Tennis for Two, se creó en 1958 usando un osciloscopio.",
            @"Tetris es uno de los videojuegos más vendidos de la historia.",
            @"El personaje Pac-Man fue diseñado a partir de una pizza a la que le faltaba una rebanada."
        ]
    };

    self.ultimoIndice = [NSMutableDictionary dictionary];

    [self configurarInterfaz];
}

#pragma mark - Interfaz

- (void)configurarInterfaz {
    self.botonCulturaGeneral = [self crearBotonCategoriaConTitulo:@"Cultura general"];
    self.botonCine = [self crearBotonCategoriaConTitulo:@"Cine"];
    self.botonVideojuegos = [self crearBotonCategoriaConTitulo:@"Videojuegos"];

    UIStackView *stackCategorias = [[UIStackView alloc] initWithArrangedSubviews:@[
        self.botonCulturaGeneral, self.botonCine, self.botonVideojuegos
    ]];
    stackCategorias.axis = UILayoutConstraintAxisVertical;
    stackCategorias.spacing = 12;
    stackCategorias.distribution = UIStackViewDistributionFillEqually;
    stackCategorias.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:stackCategorias];

    self.categoriaLabel = [[UILabel alloc] init];
    self.categoriaLabel.font = [UIFont boldSystemFontOfSize:16];
    self.categoriaLabel.textColor = [UIColor systemPurpleColor];
    self.categoriaLabel.textAlignment = NSTextAlignmentCenter;
    self.categoriaLabel.accessibilityIdentifier = @"categoriaLabel";
    self.categoriaLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.categoriaLabel];

    self.datoLabel = [[UILabel alloc] init];
    self.datoLabel.numberOfLines = 0;
    self.datoLabel.font = [UIFont systemFontOfSize:16];
    self.datoLabel.textAlignment = NSTextAlignmentCenter;
    self.datoLabel.backgroundColor = [UIColor secondarySystemBackgroundColor];
    self.datoLabel.layer.cornerRadius = 10;
    self.datoLabel.clipsToBounds = YES;
    self.datoLabel.accessibilityIdentifier = @"datoLabel";
    self.datoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.datoLabel];

    self.botonNuevoDato = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.botonNuevoDato setTitle:@"Nuevo dato" forState:UIControlStateNormal];
    self.botonNuevoDato.backgroundColor = [UIColor systemPurpleColor];
    [self.botonNuevoDato setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.botonNuevoDato.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    self.botonNuevoDato.layer.cornerRadius = 8;
    self.botonNuevoDato.hidden = YES;
    self.botonNuevoDato.translatesAutoresizingMaskIntoConstraints = NO;
    [self.botonNuevoDato addTarget:self action:@selector(mostrarNuevoDato) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.botonNuevoDato];

    self.botonCompartir = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.botonCompartir setTitle:@"Compartir" forState:UIControlStateNormal];
    self.botonCompartir.backgroundColor = [UIColor systemPurpleColor];
    [self.botonCompartir setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.botonCompartir.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    self.botonCompartir.layer.cornerRadius = 8;
    self.botonCompartir.hidden = YES;
    self.botonCompartir.translatesAutoresizingMaskIntoConstraints = NO;
    [self.botonCompartir addTarget:self action:@selector(compartirDato) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.botonCompartir];

    UILayoutGuide *guide = self.view.safeAreaLayoutGuide;

    [NSLayoutConstraint activateConstraints:@[
        [self.tituloLabel.topAnchor constraintEqualToAnchor:guide.topAnchor constant:24],
        [self.tituloLabel.leadingAnchor constraintEqualToAnchor:guide.leadingAnchor constant:20],
        [self.tituloLabel.trailingAnchor constraintEqualToAnchor:guide.trailingAnchor constant:-20],

        [stackCategorias.topAnchor constraintEqualToAnchor:guide.topAnchor constant:24],
        [stackCategorias.leadingAnchor constraintEqualToAnchor:guide.leadingAnchor constant:20],
        [stackCategorias.trailingAnchor constraintEqualToAnchor:guide.trailingAnchor constant:-20],
        [stackCategorias.heightAnchor constraintEqualToConstant:156],

        [self.categoriaLabel.topAnchor constraintEqualToAnchor:stackCategorias.bottomAnchor constant:32],
        [self.categoriaLabel.leadingAnchor constraintEqualToAnchor:guide.leadingAnchor constant:20],
        [self.categoriaLabel.trailingAnchor constraintEqualToAnchor:guide.trailingAnchor constant:-20],

        [self.datoLabel.topAnchor constraintEqualToAnchor:self.categoriaLabel.bottomAnchor constant:12],
        [self.datoLabel.leadingAnchor constraintEqualToAnchor:guide.leadingAnchor constant:20],
        [self.datoLabel.trailingAnchor constraintEqualToAnchor:guide.trailingAnchor constant:-20],
        [self.datoLabel.heightAnchor constraintGreaterThanOrEqualToConstant:120],

        [self.botonNuevoDato.topAnchor constraintEqualToAnchor:self.datoLabel.bottomAnchor constant:24],
        [self.botonNuevoDato.centerXAnchor constraintEqualToAnchor:guide.centerXAnchor],
        [self.botonNuevoDato.widthAnchor constraintEqualToConstant:160],
        [self.botonNuevoDato.heightAnchor constraintEqualToConstant:44],

        [self.botonCompartir.topAnchor constraintEqualToAnchor:self.botonNuevoDato.bottomAnchor constant:12],
        [self.botonCompartir.centerXAnchor constraintEqualToAnchor:guide.centerXAnchor],
        [self.botonCompartir.widthAnchor constraintEqualToConstant:160],
        [self.botonCompartir.heightAnchor constraintEqualToConstant:44],
    ]];
}

- (UIButton *)crearBotonCategoriaConTitulo:(NSString *)titulo {
    UIButton *boton = [UIButton buttonWithType:UIButtonTypeSystem];
    [boton setTitle:titulo forState:UIControlStateNormal];
    boton.backgroundColor = [UIColor systemIndigoColor];
    [boton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    boton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    boton.layer.cornerRadius = 8;
    [boton addTarget:self action:@selector(seleccionarCategoria:) forControlEvents:UIControlEventTouchUpInside];
    return boton;
}

#pragma mark - Lógica

- (void)seleccionarCategoria:(UIButton *)sender {
    self.categoriaSeleccionada = sender.titleLabel.text;
    self.categoriaLabel.text = self.categoriaSeleccionada;
    self.botonNuevoDato.hidden = NO;
    self.botonCompartir.hidden = NO;
    [self.ultimoIndice removeObjectForKey:self.categoriaSeleccionada];
    [self mostrarNuevoDato];
}

- (void)mostrarNuevoDato {
    if (!self.categoriaSeleccionada) {
        return;
    }

    NSArray<NSString *> *datos = self.datosCuriosos[self.categoriaSeleccionada];
    NSInteger nuevoIndice = arc4random_uniform((uint32_t)datos.count);

    NSNumber *indiceAnterior = self.ultimoIndice[self.categoriaSeleccionada];
    if (datos.count > 1) {
        while (indiceAnterior != nil && nuevoIndice == indiceAnterior.integerValue) {
            nuevoIndice = arc4random_uniform((uint32_t)datos.count);
        }
    }

    self.ultimoIndice[self.categoriaSeleccionada] = @(nuevoIndice);
    self.datoLabel.text = [NSString stringWithFormat:@"¿Sabías qué? %@", datos[nuevoIndice]];
}

- (void)compartirDato {
    if (!self.datoLabel.text) {
        return;
    }
    UIActivityViewController *actividad = [[UIActivityViewController alloc] initWithActivityItems:@[self.datoLabel.text] applicationActivities:nil];
    actividad.popoverPresentationController.sourceView = self.botonCompartir;
    [self presentViewController:actividad animated:YES completion:nil];
}

@end
