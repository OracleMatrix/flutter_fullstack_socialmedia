import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.getUserData();
    });
    return Obx(() {
      if (controller.isLoading) {
        return Center(
          child: LoadingAnimationWidget.beat(color: Colors.blue, size: 60),
        );
      }
      return Scaffold(
        appBar: AppBar(title: Text('Profile view'), centerTitle: true),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CircleAvatar(
                  radius: 100,
                  child: Icon(Icons.person, size: 100),
                ),
              ),
              Text(
                controller.userData.value.name ?? 'No Name',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                controller.userData.value.email ?? 'No Email',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        controller.nameController.value.text =
                            controller.userData.value.name ?? '';
                        controller.emailController.value.text =
                            controller.userData.value.email ?? '';
                        controller.passwordController.value.text = '';
                        controller.confirmPasswordController.value.text = '';
                        controller.isPasswordVisible.value = false;

                        Get.bottomSheet(
                          backgroundColor: Colors.grey.shade800,
                          SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Update User Data',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  TextField(
                                    controller: controller.nameController.value,
                                    decoration: InputDecoration(
                                      labelText: 'Name',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  TextField(
                                    controller:
                                        controller.emailController.value,
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  SizedBox(height: 15),
                                  Obx(
                                    () => TextField(
                                      controller:
                                          controller.passwordController.value,
                                      obscureText:
                                          !controller.isPasswordVisible.value,
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            controller.isPasswordVisible.value
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                          ),
                                          onPressed: () {
                                            controller.isPasswordVisible.value =
                                                !controller
                                                    .isPasswordVisible
                                                    .value;
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Obx(
                                    () => TextField(
                                      controller:
                                          controller
                                              .confirmPasswordController
                                              .value,
                                      obscureText:
                                          !controller.isPasswordVisible.value,
                                      decoration: InputDecoration(
                                        labelText: 'Confirm Password',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 25),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(double.infinity, 50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (controller
                                              .passwordController
                                              .value
                                              .text !=
                                          controller
                                              .confirmPasswordController
                                              .value
                                              .text) {
                                        Get.snackbar(
                                          'Error',
                                          'Passwords do not match',
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white,
                                          icon: Icon(
                                            Icons.error,
                                            color: Colors.white,
                                          ),
                                        );
                                        return;
                                      } else if (controller
                                              .nameController
                                              .value
                                              .text
                                              .isEmpty ||
                                          controller
                                              .emailController
                                              .value
                                              .text
                                              .isEmpty) {
                                        Get.snackbar(
                                          'Error',
                                          'Name and Email cannot be empty',
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white,
                                          icon: Icon(
                                            Icons.error,
                                            color: Colors.white,
                                          ),
                                        );
                                      } else if (controller
                                              .passwordController
                                              .value
                                              .text
                                              .length <
                                          6) {
                                        Get.snackbar(
                                          'Error',
                                          'Password must be at least 6 characters long',
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white,
                                          icon: Icon(
                                            Icons.error,
                                            color: Colors.white,
                                          ),
                                        );
                                      }
                                      Get.back();
                                      await controller.updateUserData();
                                    },
                                    child: Text('Update'),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                          isScrollControlled: true,
                        );
                      },
                      label: Text(
                        'Edit',
                        style: TextStyle(color: Colors.white),
                      ),
                      icon: Icon(Icons.edit, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        Get.defaultDialog(
                          title: 'Confirm Delete',
                          middleText:
                              'Are you sure you want to delete your account? This action cannot be undone.',
                          textConfirm: 'Delete',
                          textCancel: 'Cancel',
                          confirmTextColor: Colors.white,
                          onConfirm: () async {
                            Get.back();
                            await controller.deleteUser();
                          },
                          onCancel: () {},
                        );
                      },
                      label: Text(
                        'Delete account',
                        style: TextStyle(color: Colors.white),
                      ),
                      icon: Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
