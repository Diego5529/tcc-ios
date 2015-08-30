#import "ViewController.h"
#import "MenuViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(IBAction)buttonLoginTap:(id)sender{
    MenuViewController * menuVC = [[MenuViewController alloc] initWithNibName:nil bundle:nil];
    
    [self presentViewController:menuVC animated:YES completion:nil];
}

@end
