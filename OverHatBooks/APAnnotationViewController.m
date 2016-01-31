//
//  APAnnotationViewController.m
//  OverHatBooks
//
//  Created by Adrian Polo Alcaide on 31/01/16.
//  Copyright © 2016 Adrian Polo Alcaide. All rights reserved.
//

#import "APAnnotationViewController.h"
#import "APBook.h"
#import "APAnnotation.h"
#import "APPhoto.h"
#import "NSString+Validation.h"
#import "UIImage+Resize.h"


@interface APAnnotationViewController () <UITextFieldDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) APBook *book;
@property (nonatomic, strong) UIImage *photo;
@property (nonatomic, strong) APAnnotation *annotation;
@end

@implementation APAnnotationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.annotation != nil) {
        self.titleAnnotation.text = self.annotation.name;
        self.textAnnotation.text = self.annotation.text;
        if(self.photo == nil){
            if (self.annotation.photo.image) {
                self.photo = self.annotation.photo.image;
                self.imageAnnotation.image = self.annotation.photo.image;
            }
        }
        
    }
    
    [self setNavigationBar];
    
    [self setupInputAccessoryView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(id)initWithBook:(APBook *)aBook{
    if(self = [super init]){
        self.book = aBook;
        self.annotation = nil;
        self.photo = nil;
    }
    return self;
}

-(id)initWithAnnotation:(APAnnotation *)anAnnotation{
    if(self = [super init]){
        self.annotation = anAnnotation;
        self.book = nil;
        self.photo = nil;
    }
    return self;
}

#pragma mark - NavigationBar
-(void)setNavigationBar{
    if (self.navigationItem) {
        UIBarButtonItem *saveBtn =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
        self.navigationItem.rightBarButtonItem =saveBtn;
        UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
        self.navigationItem.leftBarButtonItem =cancelBtn;
    }
    
}

-(IBAction)save:(id)sender{
    if ([NSString isEmpty:self.titleAnnotation.text]) {
        [self showAlertWithMessage:@"Annotation must have a title"];
    }else if ([NSString isEmpty:self.textAnnotation.text] && !self.imageAnnotation){
        [self showAlertWithMessage:@"Annotation must have a text or a photo"];
    }else{
        [self hideKeyboard:self];
        if (self.annotation) {
            self.annotation.name = self.titleAnnotation.text;
            self.annotation.text = self.textAnnotation.text;
            self.annotation.photo.image = self.photo;
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                APAnnotation *annotation = [APAnnotation annotationOnBook:self.book withTitle:self.titleAnnotation.text text:self.textAnnotation.text photo:self.photo context:self.book.managedObjectContext];
                
                [self.book addAnnotationObject:annotation];
                [self dismissViewControllerAnimated:YES completion:nil];
            });
            
        }
    }
}

-(IBAction)cancel:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)addPhoto:(id)sender {
    if (!self.photo) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            // ask user if he wants to take a new picture or use an existing one.
            [self askForTakingPhotoOrPickFromLibrary];
        } else {
            [self launchImagePickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
    } else {
        [self deleteCurrentPicture];
    }
    
}

-(void)showAlertWithMessage:(NSString *)message{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *btn = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:btn];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark -  TextView
-(void) setupInputAccessoryView{
    
    UIToolbar *textBar = [[UIToolbar alloc] initWithFrame:CGRectMake(-100,-100, self.textAnnotation.frame.size.width, 44)];
    
    // Buttons
    UIBarButtonItem *sep = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(hideKeyboard:)];
    
    UIBarButtonItem *tab = [[UIBarButtonItem alloc] initWithTitle:@"|-->"
                                                            style:UIBarButtonItemStylePlain
                                                           target:self
                                                           action:@selector(insertTitle:)];
    [textBar setItems: @[tab, sep, done]];
    
    self.textAnnotation.inputAccessoryView = textBar;
}

-(void)insertTitle:(UIBarButtonItem *)sender{
    [self.textAnnotation insertText:[NSString stringWithFormat:@"%s ", "\t"]];
}

-(void)hideKeyboard:(id) sender{
    [self.view endEditing:YES];
}


- (void)askForTakingPhotoOrPickFromLibrary {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Do you want to...?"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *photoBtn = [UIAlertAction actionWithTitle:@"Take a picture"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
                                                         [self launchImagePickerWithSourceType:UIImagePickerControllerSourceTypeCamera];
                                                         ;
                                                     }];
    UIAlertAction *libraryBtn = [UIAlertAction actionWithTitle:@"Select one from Library"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action) {
                                                           [self launchImagePickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                                                           ;
                                                       }];
    UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"Cancel"
                                                        style: UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction * action) {
                                                          [alert dismissViewControllerAnimated:YES completion:nil];
                                                      }];
    [alert addAction:photoBtn];
    [alert addAction:libraryBtn];
    [alert addAction:cancelBtn];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)deleteCurrentPicture {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Do you want to remove current photo?"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *removeBtn = [UIAlertAction actionWithTitle:@"YES"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action) {
                                                          self.photo = nil;
                                                          self.imageAnnotation.image = [UIImage imageNamed:@"placeholder_image"];
                                                      }];
    UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"No"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction * action) {
                                                          [alert dismissViewControllerAnimated:YES completion:nil];
                                                      }];
    [alert addAction:removeBtn];
    [alert addAction:cancelBtn];
    
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - UIImagePickerController

- (void)launchImagePickerWithSourceType:(UIImagePickerControllerSourceType)sourceType {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = sourceType;
    picker.delegate = self;
    picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:picker
                       animated:YES
                     completion:^{
                         // Cuando termine la animación que muestra el picker
                         // se ejecutará este bloque.
                     }];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    __block UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat screenScale = [[UIScreen mainScreen] scale];
    CGSize screenSize = CGSizeMake(screenBounds.size.height * screenScale, screenBounds.size.width * screenScale);
    
    [self.imageActivityIndicator startAnimating];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        img = [img resizedImage:screenSize interpolationQuality:kCGInterpolationMedium];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.photo = img;
            self.imageAnnotation.image = img;
            [self.imageActivityIndicator stopAnimating];
        });
    });
    
    // Ocultar el presented VC
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 // Cuando termine la animación que oculta el picker
                                 // se ejecutará este bloque.
                             }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    // Ocultar el presented VC
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 // Cuando termine la animación que oculta el picker
                                 // se ejecutará este bloque.
                             }];
}


@end
