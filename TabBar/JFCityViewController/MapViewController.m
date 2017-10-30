//
//  MapViewController.m
//  QKParkTime
//
//  Created by 李加建 on 2017/9/12.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "MapViewController.h"

#import <MapKit/MapKit.h>
#import <MapKit/MKFoundation.h>

#import "MKMapUtils.h"

@interface MapViewController ()<MKMapViewDelegate>

@property (nonatomic ,strong)MKMapView *mapView ;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"地图导航"];
    
    [self creatMapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (void)creatMapView {
    
    _mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT-64)];
    
    [self.view addSubview:_mapView];
    
    
    [MKMapUtils cityWithAddress:_model.address location:^(double lat, double lng, NSString *city) {
        
        [self addAnnLat:lat lng:lng];
    }];
    
    
}



- (void)addAnnLat:(double)lat lng:(double)lng  {
    
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    //设置地图中心
    CLLocationCoordinate2D coordinate1;
    coordinate1.latitude = lat;
    coordinate1.longitude = lng;
    
    [self.mapView setCenterCoordinate:coordinate1 zoomLevel:13 animated:YES];
    
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    
    MKPointAnnotation *ann = [[MKPointAnnotation alloc] init];
    ann.coordinate = coordinate1;
    [ann setTitle:_model.address];
    [ann setSubtitle:@""];
    //触发viewForAnnotation
    [_mapView addAnnotation:ann];
}




@end
