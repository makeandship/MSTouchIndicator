//
//  MSTouchIndicatorTests.m
//  MSTouchIndicatorTests
//
//  Created by Simon Heys on 07/03/2015.
//  Copyright (c) 2015 Make and Ship Limited. All rights reserved.
//

// https://github.com/Specta/Specta

SpecBegin(InitialSpecs)

describe(@"these will pass", ^{
    
    it(@"can do maths", ^{
        expect(1).beLessThan(23);
    });
    
    it(@"can read", ^{
        expect(@"team").toNot.contain(@"I");
    });
    
    it(@"will wait and succeed", ^{
        waitUntil(^(DoneCallback done) {
            done();
        });
    });
});

SpecEnd

