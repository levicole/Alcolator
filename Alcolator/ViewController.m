//
//  ViewController.m
//  Alcolator
//
//  Created by Levi Kennedy on 5/27/15.
//  Copyright (c) 2015 Levi Kennedy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textFieldDidChange:(UITextField *)sender {
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber == 0) {
        sender.text = nil;
    }
}

- (IBAction)sliderValueDidChange:(UISlider *)sender {
     NSLog(@"Slider value changed to %f", sender.value);
    [self.beerPercentTextField resignFirstResponder];
    [self.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d", (int)lround([self convertBeverage])]];
}

- (float)convertBeverage;
{
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer  = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal    = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    float ouncesInOneWineGlass    = 5;
    float alcoholPercentageOfWine = 0.13; // 13% is the average;
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal/ouncesOfAlcoholPerWineGlass;
    return numberOfWineGlassesForEquivalentAlcoholAmount;
}

- (IBAction)buttonPressed:(id)sender {
    [self.beerPercentTextField resignFirstResponder];
    int numberOfBeers = self.beerCountSlider.value;
    float numberOfWineGlassesForEquivalentAlcoholAmount = [self convertBeverage];
    
    NSString *beerText;
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beers");
    }
    
    NSString *wineText;
    if (numberOfWineGlassesForEquivalentAlcoholAmount == 1) {
        wineText = NSLocalizedString(@"glass", @"singular wine");
    } else {
        wineText = NSLocalizedString(@"glasses", @"plural of wine");
    }
    
    NSLog(@"%.1f shots of whiskey", numberOfWineGlassesForEquivalentAlcoholAmount);
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ (with %.2f%% alcohol) contains as much alcohol as %d %@ of wine.", nil), numberOfBeers, beerText,  [self.beerPercentTextField.text floatValue], (int)lround(numberOfWineGlassesForEquivalentAlcoholAmount), wineText];
    
    self.resultLabel.text = resultText;
}

- (IBAction)tapGestureDidFire:(id)sender {
    [self.beerPercentTextField resignFirstResponder];
}

@end
