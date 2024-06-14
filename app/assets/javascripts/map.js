// 甲子園球場の最小最大緯度と経度
const koshienBounds = [
  {
    min_latitude: 34 + 43/60.0 + 13.353/3600.0,
    max_latitude: 34 + 43/60.0 + 20.657/3600.0,
    min_longitude: 135 + 21/60.0 + 39.414/3600.0,
    max_longitude: 135 + 21/60.0 + 44.148/3600.0
  },   //真ん中
  {
    min_latitude: 34 + 43/60.0 + 17.787/3600.0,
    max_latitude: 34 + 43/60.0 + 20.009/3600.0,
    min_longitude: 135 + 21/60.0 + 37.547/3600.0,
    max_longitude: 135 + 21/60.0 + 45.750/3600.0
  },   //左右上真ん中
  {
    min_latitude: 34 + 43/60.0 + 15.314/3600.0,
    max_latitude: 34 + 43/60.0 + 17.787/3600.0,
    min_longitude: 135 + 21/60.0 + 37.452/3600.0,
    max_longitude: 135 + 21/60.0 + 46.343/3600.0
  },    //左右真ん中
  {
    min_latitude: 34 + 43/60.0 + 13.588/3600.0,
    max_latitude: 34 + 43/60.0 + 15.314/3600.0,
    min_longitude: 135 + 21/60.0 + 37.619/3600.0,
    max_longitude: 135 + 21/60.0 + 46.343/3600.0
  }];
// ユーザーの位置が甲子園球場の範囲内にあるかどうかを判断する関数
function isInsideKoshien(latitude, longitude) {
  return (
    latitude >= koshienBounds.min_latitude &&
    latitude <= koshienBounds.max_latitude &&
    longitude >= koshienBounds.min_longitude &&
    longitude <= koshienBounds.max_longitude
  );
}

// 関数をエクスポート
export { isInsideKoshien };