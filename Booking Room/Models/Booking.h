//
//  Booking.h
//  Booking Room
//
//  Created by Sandra Guzman on 06/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MeetingRoom.h"
#import "Person.h"

@interface Booking : NSObject

@property (strong, nonatomic) NSNumber *identifier;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;
@property (strong, nonatomic) Person *owner;
@property (strong, nonatomic) NSMutableArray *assistants;
@property (strong, nonatomic) NSDate *createAt;
@property (strong, nonatomic) MeetingRoom *meetingRoom;
@property (assign, nonatomic) NSNumber *priority;
@property (assign, nonatomic) NSNumber *status;
@property (strong, nonatomic) NSDate *statusDate;

- (id)initWithIdentifier:(NSNumber *)aIdentifier
                   title:(NSString *)aTitle
               startDate:(NSDate *)aStartDate
                 endDate:(NSDate *)aEndDate
                   owner:(Person *)aOwner
              assistants:(NSMutableArray *)anAssistants
                createAt:(NSDate *)aCreateAt
             meetingRoom:(MeetingRoom *)aMeetingRoom
                priority:(NSNumber *)aPriority
                  status:(NSNumber *)aStatus
              statusDate:(NSDate *)aStatusDate;

@end
