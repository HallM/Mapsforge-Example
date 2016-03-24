//
//  ViewController.m
//  Mapsforge Example
//
//  Created by Matthew Hall on 8/28/15.
//  Copyright (c) 2015 Matthew Hall. All rights reserved.
//

#import "ViewController.h"

#import "IOSGraphicFactory.h"
#import "AssetRenderTheme.h"

#import "org/mapsforge/map/layer/cache/TileCache.h"
#import "org/mapsforge/map/layer/cache/InMemoryTileCache.h"
#import "org/mapsforge/map/layer/cache/FileSystemTileCache.h"
#import "org/mapsforge/map/layer/cache/TwoLevelTileCache.h"
#import "org/mapsforge/map/layer/renderer/TileRendererLayer.h"
#import "org/mapsforge/map/layer/Layers.h"
#import "org/mapsforge/map/rendertheme/InternalRenderTheme.h"

#import "org/mapsforge/map/model/MapViewPosition.h"
#import "org/mapsforge/map/model/Model.h"
#import "org/mapsforge/core/model/MapPosition.h"
#import "org/mapsforge/core/model/LatLong.h"

#import "org/mapsforge/map/reader/MapDataStore.h"
#import "org/mapsforge/map/reader/MapFile.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    NSLog(@"test %@", mapView);

    // it's there, trust me for now.
    IOSGraphicFactory *graphicFactory = [IOSGraphicFactory instance];
    NSLog(@"%@", graphicFactory);
    id<OrgMapsforgeMapLayerCacheTileCache> tileCache = [self createTileCache];
    
    NSString *mapPath = [[NSBundle mainBundle] pathForResource:@"texas" ofType:@"map"];
    NSString *renderThemePath = [[NSBundle mainBundle] pathForResource:@"driving" ofType:@"xml"];

    NSLog(@"map file: %@", mapPath);
    NSLog(@"render theme: %@", renderThemePath);
    
    id<OrgMapsforgeMapReaderMapDataStore> mapData = [[OrgMapsforgeMapReaderMapFile alloc] initWithNSString:mapPath];

    OrgMapsforgeMapLayerRendererTileRendererLayer *tileRendererLayer = [[OrgMapsforgeMapLayerRendererTileRendererLayer alloc]
                                            initWithOrgMapsforgeMapLayerCacheTileCache:tileCache
                                            withOrgMapsforgeMapReaderMapDataStore:mapData
                                            withOrgMapsforgeMapModelMapViewPosition:[mapView getModel]->mapViewPosition_
                                            withBoolean:false
                                            withBoolean:true
                                            withOrgMapsforgeCoreGraphicsGraphicFactory:graphicFactory];

    AssetRenderTheme *renderTheme = [[AssetRenderTheme alloc] initWithAssetPath:renderThemePath];
    [tileRendererLayer setXmlRenderThemeWithOrgMapsforgeMapRenderthemeXmlRenderTheme:renderTheme];

    [[[mapView getLayerManager] getLayers] addWithOrgMapsforgeMapLayerLayer:tileRendererLayer];
    
    OrgMapsforgeCoreModelLatLong *startCoord = [[OrgMapsforgeCoreModelLatLong alloc] initWithDouble:29.4908089 withDouble:-95.097977];
    OrgMapsforgeCoreModelMapPosition *startPos = [[OrgMapsforgeCoreModelMapPosition alloc] initWithOrgMapsforgeCoreModelLatLong:startCoord withByte:(jbyte)14];
    
    [[mapView getModel]->mapViewPosition_ setMapPositionWithOrgMapsforgeCoreModelMapPosition:startPos];

    NSLog(@"%f %f", [[mapView getModel]->mapViewPosition_ getCenter]->latitude_, [[mapView getModel]->mapViewPosition_ getCenter]->longitude_);
    [mapView repaint];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id<OrgMapsforgeMapLayerCacheTileCache>)createTileCache {
    // TODO: determine real numbers of tiles to cache!
    OrgMapsforgeMapLayerCacheInMemoryTileCache *inMemCache = [[OrgMapsforgeMapLayerCacheInMemoryTileCache alloc] initWithInt:16];
    return inMemCache;
}

@end
