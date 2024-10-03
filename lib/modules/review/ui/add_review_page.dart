import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:whats_on_restaurant/common/di.dart';
import 'package:whats_on_restaurant/modules/review/interactor/review_interactor.dart';
import 'package:whats_on_restaurant/modules/review/viewmodel/add_review_view_model.dart';

class AddReviewPage extends StatefulWidget {
  static const routeName = '/add_review';

  final Map<String, String> data;

  const AddReviewPage({super.key, required this.data});

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddReviewViewModel(
        interactor: DependencyInjection.getIt.get<ReviewInteractor>(),
        id: widget.data['id'] ?? ''
      ),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Add Review"
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data['name'] ?? 'Unknown',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    'Add Your Review',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      "Name",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)
                        ),
                        hintMaxLines: 1,
                        hintText: 'Enter your name for review'
                      ),
                      maxLines: 1,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cannot be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "Review",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)
                        ),
                        hintMaxLines: 1,
                        hintText: 'Write your honest review!'
                      ),
                      maxLines: 8,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cannot be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: SizedBox(
                      height: 54,
                      width: double.infinity,
                      child: Consumer<AddReviewViewModel>(
                        builder: (context, viewModel, _) {
                          return ElevatedButton(
                            onPressed: () {
                              // TODO: Add Review Logic
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Processing Data')),
                                );
                              }
                            }, 
                            style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                            child: Text(
                              'Submit My Review'
                            )
                          );
                        }
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}