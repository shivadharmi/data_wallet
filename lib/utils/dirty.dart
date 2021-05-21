// Container(
// decoration: BoxDecoration(
// color: CustomColors.secondary,
// borderRadius: BorderRadius.only(
// topLeft: Radius.circular(50),
// topRight: Radius.circular(50),
// ),
// ),
// child: accountsProvider.length == 0
// ? Center(
// child: Text('No Accounts Yet!'),
// )
// : ListView.builder(
// itemBuilder: (ctx, i) {
// return GestureDetector(
// onTap: () {
// _showAccInfoModalBottomSheet(
// accountsProvider.accounts[i].id,
// );
// },
// child: SizedBox(
// child: Padding(
// padding: const EdgeInsets.all(8.0),
// child: Column(
// children: [
// Row(
// // crossAxisAlignment: CrossAxisAlignment.baseline,
// children: [
// Container(
// width: 60,
// height: 50,
// child: Image.asset(
// accountsProvider
//     .accounts[i].imageUrl,
// ),
// ),
// SizedBox(
// width: 20,
// ),
// Column(
// crossAxisAlignment:
// CrossAxisAlignment.start,
// mainAxisAlignment:
// MainAxisAlignment.center,
// children: [
// Text(
// accountsProvider
//     .accounts[i].name,
// softWrap: true,
// style: TextStyle(
// fontWeight: FontWeight.bold,
// fontSize: 16,
// color: Theme.of(context)
//     .primaryColor,
// ),
// ),
// SizedBox(
// width: 220,
// child: Text(
// accountsProvider
//     .accounts[i].userName,
// overflow:
// TextOverflow.ellipsis,
// style: TextStyle(
// textBaseline: TextBaseline
//     .ideographic,
// fontSize: 14,
// ),
// ),
// ),
// ],
// ),
// ],
// ),
// Divider(
// thickness: 1.5,
// indent: 15,
// endIndent: 15,
// )
// ],
// ),
// ),
// ),
// );
// },
// itemCount: accountsProvider.length,
// ),
// ),
