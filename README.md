## Login_check.dart

`FirebaseAuth.instance.authStateChanges(),`

The `authStateChanges()` method in Firebase Authentication is specifically designed to track the user's authentication state. It returns a Stream that emits the current user when auth state changes occur, including:

1. When a user signs in
2. When a user signs out
3. When the current user's token refreshes
4. When the current user is deleted

# Register_page.dart

We are creating a user here

```dart
await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passswordController.text.trim(),
        );
```

So after this code the user is created thus we have now access to the `currentUser` 

That’s why we can now set the additional details about it like this

```dart
void addUserDetails() async {
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set({
      'first Name': _firstNameController.text.trim(),
      'last name': _lastNameController.text.trim(),
      'age': _ageController.text.trim(),
      'email': _emailController.text.trim(),
    });
  }
```

And here basically inside of the user collection we are using the currentUser uid to store data inside 

`await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set({`

later we can access the data easily using the uid like this: 

`FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();`

# Logged_in.dart

## For try catch error handling

In firebase you can use this on `FirebaseAuthException catch (e)` 

for example for Sign in method here

```dart
Future signIn() async {
    setState(() {
      _isloading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passswordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isloading = false;
      });
      _customSnackbar(text: e.message.toString());
    }
  }
```

## Getting the current user

To get the current user we can use variables like this

`final user = FirebaseAuth.instance.currentUser!;`

## Mounted

```dart
if (mounted) {
      // Check if the widget is still in the tree
      if (getData.exists) {
        setState(() {
          userdata = getData.data() as Map;
        });
      }
    }
```

`mounted` is just for the safety incase if the user leaves the screen when the `setState` is called, cause if the widget is not built yet and the `setState` is called then it will show an error. So basically `setState` is only called after the whole widget gets built and `mounted` ensures that happens and if the user leaves before the widget gets built then `setState` is not called. So it’s a bool, `mounted` checks if the widget is built fully.

## InitState

```dart
@override
  void initState() {
  super.initState();
  getUserData();
  fireService = FirestoreService(notes: userCollection.doc(user.uid).collection('notes'),
    );
  }
```

So here in initState these two are here because 

```dart
getUserData();
fireService = FirestoreService(notes: userCollection.doc(user.uid).collection('notes')) 
```

they are needed to fetch that that’ll be shown in the screen, so their data needed to be fetched first. And also there is `late final FirestoreService fireService;` And about that:

## late in Dart

The `late` keyword signifies that the variable will be initialized at some point before its first use, but not necessarily immediately upon declaration.

Since fireSerivce is needed for the Scaffold and also for `openNoteBox` method. It needs to be initialized before those two.
