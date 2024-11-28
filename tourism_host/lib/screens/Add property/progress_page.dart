
import 'package:flutter/material.dart';
import 'package:tourism_host/screens/Add%20property/Place%20Shining/add_amenities.dart';
import 'package:tourism_host/screens/Add%20property/Place%20Shining/add_photos.dart';
import 'package:tourism_host/screens/Add%20property/Place%20Shining/name_description.dart';
import 'package:tourism_host/screens/Add%20property/Place%20Shining/package_creating.dart';
import 'package:tourism_host/screens/Add%20property/Property%20Describing/Place_type.dart';
import 'package:tourism_host/screens/Add%20property/Property%20Describing/Property_type_selection.dart';
import 'package:tourism_host/screens/Add%20property/Property%20Describing/property_location.dart';
import 'package:tourism_host/screens/Add%20property/Property%20Describing/space_usage.dart';
import 'package:tourism_host/screens/Add%20property/Property%20Veryfication/host_details.dart';
import 'package:tourism_host/screens/Add%20property/Property%20Veryfication/poperty_verification.dart';

class ProgressTrackerPage extends StatefulWidget {
  @override
  _ProgressTrackerPageState createState() => _ProgressTrackerPageState();
}

class _ProgressTrackerPageState extends State<ProgressTrackerPage> {
  final List<StepProgress> progressData = [
    StepProgress(
      title: "Tell us your place",
      subSteps: [
        SubStep(title: "Property Type", status: StepStatus.completed, navigationPage: PropertyTypeSelectionPage()),
        SubStep(title: "Guest Type", status: StepStatus.completed, navigationPage: PropertyGuestTypeSelectionPage()),
        SubStep(title: "Space Details", status: StepStatus.inProgress, navigationPage: SpaceDetailsPage()),
        SubStep(title: "Location", status: StepStatus.notStarted, navigationPage: PropertyLocationPage()),
      ],
    ),
    StepProgress(
      title: "Make your place shine",
      subSteps: [
        SubStep(title: "Upload Photos", status: StepStatus.notStarted, navigationPage: UploadPhotosPage()),
        SubStep(title: "Select Amenities", status: StepStatus.notStarted, navigationPage: SelectAmenitiesPage()),
        SubStep(title: "Describe Place", status: StepStatus.notStarted, navigationPage: DescribePlacePage()),
        SubStep(title: "Special Packages", status: StepStatus.notStarted, navigationPage: SpecialPackagesPage()),
      ],
    ),
    StepProgress(
      title: "Verification",
      subSteps: [
        SubStep(title: "Host Details", status: StepStatus.notStarted, navigationPage: HostDetailsPage()),
        SubStep(title: "Property Verification", status: StepStatus.notStarted, navigationPage: PropertyVerificationPage()),
      ],
    ),
  ];

  int _expandedStepIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 75),
          // Heading and instructions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Follow the steps',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Divider(color: Colors.grey),
                SizedBox(height: 8),
                Text(
                  'Follow these steps to complete your property addition. Each main step has substeps, and their progress is tracked here.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          // Progress Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                itemCount: progressData.length,
                itemBuilder: (context, index) {
                  final step = progressData[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    color: _expandedStepIndex == index
                        ? Colors.white
                        : _getMainStepColor(step),
                    child: Column(
                      children: [
                        ExpansionTile(
                          onExpansionChanged: (expanded) {
                            setState(() {
                              _expandedStepIndex = expanded ? index : -1;
                            });
                          },
                          leading: _getStepIcon(index),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                step.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              if (_isMainStepInProgress(step))
                                Text(
                                  'In Progress',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                            ],
                          ),
                          children: step.subSteps.map((subStep) {
                            int subStepIndex = step.subSteps.indexOf(subStep) + 1;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Card(
                                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
                                color: _getSubStepColor(subStep.status),
                                child: ListTile(
                                  title: Text('$subStepIndex. ${subStep.title}'),
                                  trailing: _getSubStepIcon(subStep.status),
                                  onTap: subStep.status != StepStatus.notStarted
                                      ? () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => subStep.navigationPage,
                                            ),
                                          );
                                        }
                                      : null,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 16),
          // Progress Bar
          _buildProgressBar(),
          SizedBox(height: 16),
          // 'Let's Start' Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child:ElevatedButton(
                onPressed:
                  () {
                    Navigator.pushNamed(context, '/propertyselection');
                  },
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  textStyle: TextStyle(fontSize: 16, color: Colors.white),
                  minimumSize: Size(MediaQuery.of(context).size.width, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: Text(
                  'Lets Start',
                  style: TextStyle(color: Colors.white),
                ),
              ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  // Builds the horizontal progress bar
  Widget _buildProgressBar() {
    _calculateOverallProgress();

    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: progressData.map((step) {
          int completedSteps = step.subSteps.where((subStep) => subStep.status == StepStatus.completed).length;
          int totalSteps = step.subSteps.length;

          return Expanded(
            child: Column(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  height: 8,
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    color: completedSteps == totalSteps
                        ? Colors.blueAccent
                        : completedSteps > 0
                            ? Colors.lightBlue
                            : Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  step.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: completedSteps > 0 ? Colors.black87 : Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // Get color based on substep status
  Color _getSubStepColor(StepStatus status) {
    switch (status) {
      case StepStatus.completed:
        return Colors.green[200]!;
      case StepStatus.inProgress:
        return Colors.blue[200]!;
      case StepStatus.notStarted:
      default:
        return Colors.red[100]!;
    }
  }

  // Get the icon for the substep based on its status
  Widget? _getSubStepIcon(StepStatus status) {
    if (status == StepStatus.completed) {
      return Icon(Icons.check_circle, color: Colors.green);
    } else if (status == StepStatus.inProgress) {
      return CircularProgressIndicator(color: Colors.blueAccent,);
    } else {
      return null;
    }
  }

  // Get the color for the main step card based on its status
  Color _getMainStepColor(StepProgress step) {
    if (step.subSteps.every((subStep) => subStep.status == StepStatus.completed)) {
      return Colors.green[50]!;
    } else if (_isMainStepInProgress(step)) {
      return Colors.lightBlue[50]!;
    } else {
      return Colors.white;
    }
  }

  // Get the icon for each main step
  Widget _getStepIcon(int index) {
    switch (index) {
      case 0:
        return Icon(Icons.place, color: Colors.black);
      case 1:
        return Icon(Icons.camera, color: Colors.black);
      case 2:
        return Icon(Icons.check_circle, color: Colors.black);
      default:
        return Icon(Icons.account_box, color: Colors.black);
    }
  }

  // Check if the main step is in progress
  bool _isMainStepInProgress(StepProgress step) {
    return step.subSteps.any((subStep) => subStep.status == StepStatus.inProgress);
  }

  // Calculate overall progress
  void _calculateOverallProgress() {
    // This can be updated later for overall progress calculation if needed
  }
}

// Enum for substep status
enum StepStatus { completed, inProgress, notStarted }

// Model for a step
class StepProgress {
  final String title;
  final List<SubStep> subSteps;

  StepProgress({required this.title, required this.subSteps});
}

// Model for a substep
class SubStep {
  final String title;
  final StepStatus status;
  final Widget navigationPage;

  SubStep({required this.title, required this.status, required this.navigationPage});
}
