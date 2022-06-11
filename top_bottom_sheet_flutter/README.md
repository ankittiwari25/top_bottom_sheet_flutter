# About
    -This plugin will help you to show the bottom sheet to the top of the screen
## Parameters
- isShowCloseButton
- closeButtonRadius
- closeButtonBackgroundColor
- closeButtonIcon
- child
- context

## Installation

Install the dependencies and devDependencies and start the server.

```sh
flutter pub add top_bottom_sheet_flutter
flutter pub get
```
Or

```sh
dependencies:
  top_bottom_sheet_flutter: $currentVersion$
```
# Example

```sh
  void showSheet() {
    TopModalSheet.show(
        context: context,
        isShowCloseButton: true,
        closeButtonRadius: 20.0,
        closeButtonBackgroundColor: Colors.white,
        child: Container(
          color: Colors.white,
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: const Text('Ankit Tiwari'),
                  subtitle: const Text('tiwariankit496@gmail.com'),
                  leading: FloatingActionButton(
                    heroTag: index,
                    backgroundColor: Colors.white,
                    onPressed: () {},
                    child: const FlutterLogo(),
                  ),
                );
              },
              itemCount: 30,
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            ),
          ),
        ));
  }
```

# Screenshot

![Screenshot_2022_06_11_15_38_01_686_com_example_test_demo_ankit](https://user-images.githubusercontent.com/54878509/173183909-bbfdabe0-9644-444e-aa99-029c1e06cfb9.jpg)
![Screenshot_2022_06_11_15_37_19_088_com_example_test_demo_ankit](https://user-images.githubusercontent.com/54878509/173183910-62f1977f-a4ff-4d33-9cc9-746d64f9a5fe.jpg)

# How to reach us
- tiwariankit496@gmail.com
- https://github.com/ankittiwari25

















