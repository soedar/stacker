//
//  PlaymonWalletViewController.m
//  Stacker
//
//  Created by soedar on 17/4/13.
//  Copyright (c) 2013 Playmon. All rights reserved.
//

#import "PlaymonWalletViewController.h"
#import "Constants.h"
#import "GiftCard.h"

@interface PlaymonWalletViewController ()

@property (nonatomic, strong) NSMutableArray *giftCards;
@property (nonatomic, weak) IBOutlet UITableView *purchaseTableView;

@end

@implementation PlaymonWalletViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Wallet";
        self.view.backgroundColor = BACKGROUND_COLOR;
        
        [self initGiftCards];
        [self registerNotifications];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) registerNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addCard:) name:NOTIFY_ADD_CARD object:nil];
}

- (void) addCard:(NSNotification*)notification
{
    GiftCard *card = notification.userInfo[CARD_KEY];
    [self.giftCards addObject:card];
    [self.purchaseTableView reloadData];
}

- (void) initGiftCards
{
    GiftCard *appleCard = [GiftCard
                           giftCardWithImage:[UIImage imageNamed:@"itunes15.png"]
                           storeName:@"Apple"
                           distance:nil
                           title:@"Get 3 coins when you buy a $15 gift card"
                           coinsValue:3
                           cardValue:15];
    
    GiftCard *amazonCard = [GiftCard
                            giftCardWithImage:[UIImage imageNamed:@"amazon.png"]
                            storeName:@"Amazon"
                            distance:nil
                            title:@"Get 4 coins when you buy a $20 gift card"
                            coinsValue:3
                            cardValue:20];
    
    self.giftCards = [NSMutableArray arrayWithObjects:appleCard, amazonCard, nil];
}


#pragma mark - UITableView delegate and data source

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.giftCards.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellReuseId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellReuseId];
    }
    
    ;
    GiftCard *card = [[self.giftCards reverseObjectEnumerator] allObjects][indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ $%i", card.storeName, card.cardValue];
    cell.textLabel.textColor = TEXT_COLOR;
    cell.detailTextLabel.text = @"hello";
    cell.textLabel.textColor = TEXT_COLOR;
    
    return cell;
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Your Purchases";
}

@end
