//
//  WhiskeyViewController.m
//  Alcolator
//
//  Created by Levi Kennedy on 6/2/15.
//  Copyright (c) 2015 Levi Kennedy. All rights reserved.
//

#import "WhiskeyViewController.h"

@interface WhiskeyViewController ()

@end

@implementation WhiskeyViewController
- (float) convertBeverage;
{
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer  = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal    = ouncesOfAlcoholPerBeer * numberOfBeers;
    float ouncesInOneWhiskeyGlass = 1;
    float alcoholPercentageOfWhiskey = 0.4;
    float ouncesOfAlcoholPerWhiskeyGlass = ouncesInOneWhiskeyGlass * alcoholPercentageOfWhiskey;
    float numberOfWhiskeyGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWhiskeyGlass;
    return numberOfWhiskeyGlassesForEquivalentAlcoholAmount;
}

- (IBAction)sliderValueDidChange:(UISlider *)sender {
    [self.beerPercentTextField resignFirstResponder];
    float numberOfWhiskeyGlassesForEquivalentAlcoholAmount = [self convertBeverage];
    
    NSString *whiskeyText;
    if (numberOfWhiskeyGlassesForEquivalentAlcoholAmount == 1) {
        whiskeyText = NSLocalizedString(@"shot", @"singular show");
    } else {
        whiskeyText = NSLocalizedString(@"shots", @"plural of shots");
    }
    
    self.navigationItem.title = [NSString stringWithFormat:NSLocalizedString(@"Whiskey (%.1f %@)", nil), numberOfWhiskeyGlassesForEquivalentAlcoholAmount, whiskeyText];
}

- (void) buttonPressed:(UIButton *)sender;
{
    [self.beerPercentTextField resignFirstResponder];
    int numberOfBeers = self.beerCountSlider.value;
    
    float numberOfWhiskeyGlassesForEquivalentAlcoholAmount = [self convertBeverage];
    
    NSString *beerText;
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beers");
    }
    
    NSString *whiskeyText;
    if (numberOfWhiskeyGlassesForEquivalentAlcoholAmount == 1) {
        whiskeyText = NSLocalizedString(@"shot", @"singular show");
    } else {
        whiskeyText = NSLocalizedString(@"shots", @"plural of shots");
    }
    
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ (with %.2f%% alcohol) contains as much alcohol as %.1f %@ of whiskey.", nil), numberOfBeers, beerText, [self.beerPercentTextField.text floatValue], numberOfWhiskeyGlassesForEquivalentAlcoholAmount, whiskeyText];
    self.resultLabel.text = resultText;
}
@end
