// if (e.nullExist() == false) {
// return ListTile(
// title: Text(e.name!),
// subtitle: Text(
// "${e.admin2!}, ${e.admin1!}, ${e.country!}",
// ),
// );
// } else {
// if (e.admin1 == null && e.admin2 == null) {
// return ListTile(
// title: Text(e.name),
// subtitle: Text(e.country),
// );
// } else if (e.admin1 == null && e.admin2 != null) {
// return ListTile(
// title: Text(e.name),
// subtitle: Text(e.admin2! + ", " + e.country),
// );
// } else if (e.admin1 != null && e.admin2 == null) {
// return ListTile(
// title: Text(e.name),
// subtitle: Text(e.admin1! + ", " + e.country),
// );
// } else {
// return ListTile(
// title: Text(e.name),
// subtitle: Text(
// e.admin2! + ", " + e.admin1! + ", " + e.country),
// );
// }
// }
