//
//  Booking.m
//  Booking Room
//
//  Created by Sandra Guzman on 06/08/14.
//  Copyright (c) 2014 Grupo Sellcom. All rights reserved.
//

#import "Booking.h"

@implementation Booking

- (id)init {
    self = [self initWithIdentifier:0
                              title:@"Default"
                          startDate:[NSDate date]
                            endDate:[NSDate date]
                              owner:[[Person alloc]init]
                         assistants:[[NSMutableArray alloc]initWithObjects: [[Person alloc]init], nil]
                           createAt:[NSDate date]
                        meetingRoom:[[MeetingRoom alloc]init]
                           priority:0
                             status:0
                         statusDate:[NSDate date]];
    return self;
}


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
              statusDate:(NSDate *)aStatusDate {
    self = [super init];
    if(self) {
        self.identifier = aIdentifier;
        self.title = aTitle;
        self.startDate = aStartDate;
        self.endDate = aEndDate;
        self.owner = aOwner;
        self.assistants = anAssistants;
        self.createAt = aCreateAt;
        self.meetingRoom = aMeetingRoom;
        self.priority = aPriority;
        self.status = aStatus;
        self.startDate = aStatusDate;
    }
    return self;
}

@end
