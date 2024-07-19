import 'package:flutter/material.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';

void main() {
  runApp(const SolAce());
}

class SolAce extends StatelessWidget {
  const SolAce({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SolAce',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(), // Show splash screen initially
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Simulate some initialization tasks such as loading data, etc.
    Future.delayed(const Duration(seconds: 5), () {
      // After 5 seconds, navigate to the home page
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const HomePage(),
      ));
    });

    return Scaffold(
      backgroundColor: const Color.fromRGBO(5, 90, 187, 0.8), // Set background color with opacity
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add your logo image here
            Image.asset(
              'images/logo.png', // Replace 'assets/logo.png' with your image path
              width: 500, // Adjust the width as needed
              height: 500, // Adjust the height as needed
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'images/tip.png', // Replace with your image path
            width: 50, // Adjust the width as needed
            height: 50, // Adjust the height as needed
          ),
          onPressed: () {
                // Navigate to sign up page
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const LigtasTips(),
                ));
              },
        ),
        backgroundColor: const Color.fromARGB(255, 0, 75, 161),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
             onPressed: () {
              
              },
          ),
        ],
        flexibleSpace: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Image.asset(
              'images/solace.png',
              height: 300, // Adjust the height of the image as needed
              width: 300, // Optionally, adjust the width of the image as needed
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xff002E63),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Weather Forecast',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const WeatherBox(
              date: '2024-06-04',
              temperature: 25,
              condition: 'Sunny',
            ),
            const SizedBox(height: 20),
            const Text(
              'Current Level',
              style: TextStyle(
                fontSize: 42,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 300,
              height: 200,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: WaveWidget(
                      config: CustomConfig(
                        gradients: [
                          [Colors.blue, Colors.blueAccent],
                          [Colors.blue.shade200, Colors.blueAccent.shade100],
                        ],
                        durations: [5000, 4000],
                        heightPercentages: [0.10, 0.15],
                        blur: const MaskFilter.blur(BlurStyle.solid, 0),
                        gradientBegin: Alignment.bottomLeft,
                        gradientEnd: Alignment.topRight,
                      ),
                      waveAmplitude: 0,
                      backgroundColor: Colors.transparent,
                      size: const Size(double.infinity, double.infinity),
                    ),
                  ),
                  const Center(
                    child: LevelBox(
                      color: Color.fromARGB(76, 33, 149, 243),
                      text: '5 MASL',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const LevelBox(
              color: Colors.green,
              text: 'Normal Level  6.00 MASL',
            ),
            const SizedBox(height: 10),
            const LevelBox(
              color: Colors.yellow,
              text: 'Alert Level  6.20 MASL',
            ),
            const SizedBox(height: 10),
            const LevelBox(
              color: Colors.red,
              text: 'Critical Level  7.00 MASL',
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherBox extends StatelessWidget {
  final String date;
  final int temperature;
  final String condition;

  const WeatherBox({
    Key? key,
    required this.date,
    required this.temperature,
    required this.condition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isValidDate = _isValidDate(date);
    bool isValidCondition = _isValidCondition(condition);

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isValidCondition ? Colors.yellow[200] : Colors.redAccent,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              isValidCondition
                  ? const Icon(Icons.wb_sunny, color: Colors.orange, size: 24)
                  : const Icon(Icons.error_outline, color: Colors.white, size: 24),
              const SizedBox(width: 8),
              Text(
                isValidDate ? date : 'Invalid Date',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isValidDate ? Colors.black87 : Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '$temperature°C',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            isValidCondition ? condition : 'Invalid Condition',
            style: TextStyle(
              fontSize: 18,
              color: isValidCondition ? Colors.black54 : Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  bool _isValidDate(String date) {
    try {
      DateTime.parse(date);
      return true;
    } catch (e) {
      return false;
    }
  }

  bool _isValidCondition(String condition) {
    return ['Sunny', 'Rainy', 'Cloudy'].contains(condition);
  }
}

class LevelBox extends StatelessWidget {
  final Color color;
  final String text;

  const LevelBox({
    Key? key,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}



//Ligtas Tips 

class LigtasTips extends StatelessWidget {
  const LigtasTips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LIGTAS TIPS',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF004AA1), // Set the AppBar background color
      ),
      backgroundColor: const Color(0xFF002E63), // Set background color of the Scaffold
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('images/mdrrmo.png'),
                      width: 200, // Adjust the width as needed
                      height: 235, // Adjust the height as needed
                    ),
             
                  ],
                ),
              ),
              const SizedBox(height: 10), // Add some space between images and buttons
              SizedBox(
                width: 300, // Adjust the width of the button
                child: ButtonWidget(
                  text: 'BARANGAY EVACUATION GUIDE',
                  onPressed: () {
                    // Handle button press for BARANGAY EVACUATION GUIDE
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const BarangayEvacuationGuideScreen(),
                    ));
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 300, // Adjust the width of the button
                child: ButtonWidget(
                  text: 'BAGYO AT BAHA',
                  onPressed: () {
                    // Handle button press for BAGYO AT BAHA
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const BagyoAtBahaScreen(),
                    ));
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 300, // Adjust the width of the button
                child: ButtonWidget(
                  text: 'LINDOL',
                  onPressed: () {
                    // Handle button press for LINDOL
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LindolScreen(),
                    ));
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 300, // Adjust the width of the button
                child: ButtonWidget(
                  text: 'LDRRMC',
                  onPressed: () {
                    // Handle button press for LDRRMC
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LdrrmcScreen(),
                    ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Make the button full-width
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(33, 243, 86, 0.8), // Button color with opacity
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0), // Rounded corners
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white, 
              fontSize: 16, 
              fontWeight: FontWeight.bold, // Make the font bold
            ),
          ),
        ),
      ),
    );
  }
}

// Placeholder screens for navigation



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BarangayEvacuationGuideScreen(),
    );
  }
}

class BarangayEvacuationGuideScreen extends StatelessWidget {
  const BarangayEvacuationGuideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LIGTAS TIPS',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF004AA1),
      ),
      backgroundColor: const Color(0xFF002E63),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/mdrrmo.png',
                      width: 200,
                      height: 200,
                    ),
                    const SizedBox(width: 20),
                    Image.asset(
                      'images/stabarbara.png',
                      width: 200,
                      height: 200,
                    ),
                  ],
                ),
              ),
              Container(
                color: const Color(0xFF008000),
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'MUNICIPAL DISASTER RISK REDUCTION AND MANAGEMENT OFFICE (MDRRMO)',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'BARANGAY EVACUATION GUIDE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 250,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BEG(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF008DDC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'NEXT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BEG extends StatelessWidget {
  const BEG({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen width for responsiveness
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LIGTAS TIPS',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF004AA1),
      ),
      backgroundColor: const Color(0xFFC7DDFE),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'images/BEG.png',
                  width: screenWidth, // Make the image fit the screen width
                  fit: BoxFit.contain, // Maintain aspect ratio and fit within the space
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class BagyoAtBahaScreen extends StatelessWidget {
  const BagyoAtBahaScreen({Key? key}) : super(key: key);
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LIGTAS TIPS',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF004AA1), // Set the AppBar background color
      ),
      backgroundColor: const Color(0xFF002E63), // Set background color of the Scaffold
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/mdrrmo.png',
                      width: 200, // Adjust the width as needed
                      height: 200, // Adjust the height as needed
                    ),
                    const SizedBox(width: 20), // Add some space between the images
                    Image.asset(
                      'images/stabarbara.png',
                      width: 200, // Adjust the width as needed
                      height: 200, // Adjust the height as needed
                    ),
                  ],
                ),
              ),
            
              Container(
                color: const Color(0xFF008000),
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'MUNICIPAL DISASTER RISK REDUCTION AND MANAGEMENT OFFICE (MDRRMO)',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'BAGYO AT BAHA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const Text(
                'FAMILY \n DISASTER \n PREPAREDNESS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 250, // Adjust the width of the button
                child: ElevatedButton(
                 onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BP(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XFF008DDC), // Button color with opacity
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), // Rounded corners
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'NEXT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold, // Make the font bold
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BP extends StatelessWidget {
  const BP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen width for responsiveness
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(  
      appBar: AppBar(
        title: const Text(
          'LIGTAS TIPS',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF004AA1),
      ),
      backgroundColor: const Color(0xFFC7DDFE),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'images/BP.png',
                  width: screenWidth, // Make the image fit the screen width
                  fit: BoxFit.contain, // Maintain aspect ratio and fit within the space
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class LindolScreen extends StatelessWidget {
  const LindolScreen({Key? key}) : super(key: key);
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LIGTAS TIPS',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF004AA1), // Set the AppBar background color
      ),
      backgroundColor: const Color(0xFF002E63), // Set background color of the Scaffold
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/mdrrmo.png',
                      width: 200, // Adjust the width as needed
                      height: 200, // Adjust the height as needed
                    ),
                    const SizedBox(width: 20), // Add some space between the images
                    Image.asset(
                      'images/stabarbara.png',
                      width: 200, // Adjust the width as needed
                      height: 200, // Adjust the height as needed
                    ),
                  ],
                ),
              ),
            
              Container(
                color: const Color(0xFF008000),
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'MUNICIPAL DISASTER RISK REDUCTION AND MANAGEMENT OFFICE (MDRRMO)',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'LINDOL',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const Text(
                'FAMILY \n DISASTER \n PREPAREDNESS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 250, // Adjust the width of the button
                child: ElevatedButton(
                     onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const L(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XFF008DDC), // Button color with opacity
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0), // Rounded corners
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'NEXT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold, // Make the font bold
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class L extends StatelessWidget {
  const L ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen width for responsiveness
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(  
      appBar: AppBar(
        title: const Text(
          'LIGTAS TIPS',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF004AA1),
      ),
      backgroundColor: const Color(0xFFC7DDFE),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'images/L.png',
                  width: screenWidth, // Make the image fit the screen width
                  fit: BoxFit.contain, // Maintain aspect ratio and fit within the space
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





class LdrrmcScreen extends StatelessWidget {
  const LdrrmcScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LIGTAS TIPS',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF004AA1),
      ),
      backgroundColor: const Color(0xFFC7DDFE),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    'L D R R M C',
                    style: TextStyle(
                      color: Color(0xFF002551),
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'LGU - Sta. Barbara',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 20),
              const Text.rich(
                TextSpan(
                  text: 'Please Like our Facebook Page: ',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'StaBarbaraMdrrmo',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 20),
              const Text.rich(
                TextSpan(
                  text: 'Email Address: ',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'santabarbara_idrrmc@yahoo.com',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      color: const Color(0xFFB1AAFF),
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset(
                        'images/hl.png', // Replace with your image path
                        height: 500, // Adjust as per your needs
                        width: 500, // Adjust as per your needs
                        fit: BoxFit.contain, // Adjust the image fit as needed
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '"ang pagiging handa ay isang hakbang tungo sa Raligtasan ng buhay ng inyong pamilya."',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
           
              
            ],
          ),
        ),
      ),
    );
  }
}
