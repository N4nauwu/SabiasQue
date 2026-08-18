#import <XCTest/XCTest.h>

@interface SabiasQueUITests : XCTestCase
@end

@implementation SabiasQueUITests

- (void)testFlujoCompleto {
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app launch];

    [self adjuntarCaptura:app nombre:@"01_pantalla_inicio"];


    XCUIElement *botonComenzar = app.buttons[@"COMENZAR"];
    XCTAssertTrue([botonComenzar waitForExistenceWithTimeout:5.0], @"No se encontró el botón COMENZAR");
    [botonComenzar tap];

   
    XCUIElement *botonCine = app.buttons[@"Cine"];
    XCTAssertTrue([botonCine waitForExistenceWithTimeout:5.0], @"No se encontró el botón Cine");
    [botonCine tap];

    XCUIElement *datoLabel = [app.staticTexts matchingPredicate:[NSPredicate predicateWithFormat:@"identifier == %@", @"datoLabel"]].element;
    XCTAssertTrue([datoLabel waitForExistenceWithTimeout:5.0], @"No apareció el dato curioso");
    NSString *primerDato = datoLabel.label;
    [self adjuntarCaptura:app nombre:@"02_dato_cine_primero"];

    // b) y c) Toca el botón "Nuevo dato" y verifica que cambie
    XCUIElement *botonNuevoDato = app.buttons[@"Nuevo dato"];
    XCTAssertTrue([botonNuevoDato waitForExistenceWithTimeout:5.0]);
    [botonNuevoDato tap];

    [NSThread sleepForTimeInterval:0.5];
    NSString *segundoDato = datoLabel.label;
    [self adjuntarCaptura:app nombre:@"03_dato_cine_segundo"];

    XCTAssertNotEqualObjects(primerDato, segundoDato, @"El segundo dato debería ser diferente al primero");
}

- (void)adjuntarCaptura:(XCUIApplication *)app nombre:(NSString *)nombre {
    XCUIScreenshot *captura = [app screenshot];
    XCTAttachment *adjunto = [XCTAttachment attachmentWithScreenshot:captura];
    adjunto.name = nombre;
    adjunto.lifetime = XCTAttachmentLifetimeKeepAlways;
    [self addAttachment:adjunto];
}

@end
