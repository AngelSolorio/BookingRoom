//
//  TypeDefs.h
//  Booking Room
//
//  Created by Angel Solorio on 2/27/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.


#define TYPEDEFS_FORMATDATE_YEAR_MONTH_DAY @"yyyy-MM-dd"
#define TYPEDEFS_FORMATDATE_DAY_MONTH_YEAR @"dd-MM-yyyy"
#define TYPEDEFS_NULLDATE @""
#define IDNOTIFICATIONCENTER_SAVEDEMPLOYEE @"SavedEmployee"
#define kUserLoggedNotification @"UserLoggedNotification"

typedef enum PinStatus {
    kNeverSet = 1,
	kAlreadySet,
	kToConfirm
} PinStatus;

