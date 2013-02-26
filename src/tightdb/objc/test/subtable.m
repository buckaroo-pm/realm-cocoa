//
//  subtable.m
//  TightDB
//
//  Test save/load on disk of a group with one table
//

#import <SenTestingKit/SenTestingKit.h>

#import <tightdb/objc/tightdb.h>
#import <tightdb/objc/group.h>

TIGHTDB_TABLE_2(TestSubtableSub,
                Name, String,
                Age,  Int)

TIGHTDB_TABLE_3(TestSubtableMain,
                First,  String,
                Sub,    TestSubtableSub,
                Second, Int)

@interface MACTestSubtable: SenTestCase
@end
@implementation MACTestSubtable

- (void)setUp
{
    [super setUp];

    // _group = [Group group];
    // NSLog(@"Group: %@", _group);
    // STAssertNotNil(_group, @"Group is nil");
}

- (void)tearDown
{
    // Tear-down code here.

    //  [super tearDown];
    //  _group = nil;
}

- (void)testSubtable
{
    TightdbGroup *group = [TightdbGroup group];

    /* Create new table in group */
    TestSubtableMain *people = [group getTable:@"employees" withClass:[TestSubtableMain class]];

    /* FIXME: Add support for specifying a subtable to the 'add'
       method. The subtable must then be copied into the parent
       table. */
    [people addFirst:@"first" Sub:nil Second:8];

    TestSubtableMain_Cursor *cursor = [people objectAtIndex:0];
    TestSubtableSub *subtable = cursor.Sub;
    [subtable addName:@"name" Age:999];

    STAssertEquals([subtable objectAtIndex:0].Age, (int64_t)999, @"Age should be 999");
}

@end


