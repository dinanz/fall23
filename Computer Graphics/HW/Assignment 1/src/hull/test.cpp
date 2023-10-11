////////////////////////////////////////////////////////////////////////////////
#include <algorithm>
#include <complex>
#include <fstream>
#include <iostream>
#include <numeric>
#include <vector>
#include <string>
////////////////////////////////////////////////////////////////////////////////

typedef std::complex<double> Point;
typedef std::vector<Point> Polygon;


std::vector<Point> load_xyz(const std::string &filename) {
	std::vector<Point> points;
	std::ifstream in(filename);
	// TODO
	// load points in file to points vector
	if(in.is_open()){
		// parse line by line, store into points
		// points.push_back(complex(line[0], line[1]))
		std::string s;
		std::string temp;
		std::vector<std::string> vs;
		std::getline(in, s);
		int pointCount = std::stoi(s);
		std::cout << "point cloud count = " << pointCount << std::endl;

		while(std::getline(in, s)){
			std::stringstream ss(s);
			// s = current line (deliminator by default = "\n")
			// parse s into vector by whitespace
			while(std::getline(ss, temp, ' ')){
				vs.push_back(temp);
			}
			points.push_back(Point(std::stod(vs[0]), std::stod(vs[1])));
			vs.clear();
		}

	}
	for(int i = 0; i < points.size(); i++){
		std::cout << points[i] << std::endl;
	}
	return points;
}

Polygon load_obj(const std::string &filename) {
	std::ifstream in(filename);
	// TODO
	Polygon res;
	if(in.is_open()){
		// parse line by line, store into points
		// points.push_back(complex(line[0], line[1]))
		std::string s;
		std::string temp;
		std::vector<std::string> vs;

		while(std::getline(in, s)){
			std::stringstream ss(s);
			// s = current line (deliminator by default = "\n")
			// parse s into vector by whitespace
			std::getline(ss, temp, ' '); // v
			if(temp == "f") break;
			std::getline(ss, temp, ' '); // x
			vs.push_back(temp);
			std::getline(ss, temp, ' '); // y
			vs.push_back(temp);
			
			res.push_back(Point(std::stod(vs[0]), std::stod(vs[1])));
			vs.clear();
		}

	}
    for(int i = 0; i < res.size(); i++){
        std::cout << res[i] << std::endl;
    }
	return res;
}

double inline det(const Point &u, const Point &v) {
	// TODO
	return u.real()*v.imag()-u.imag()*v.real();
}

bool inline salientAngle(Point &a, Point &b, Point &c) {
	// determine if three points form a triangle (right turn) salient angle
	// get vector ab, vector bc
	// compare slope of the two vectors
    std::cout << a << b << c << std::endl;
	double v1 = (b.imag()-a.imag())/(b.real()-a.real());
    std::cout << v1 << std::endl;

	double v2 = (c.imag()-b.imag())/(c.real()-b.real());
    std::cout << v2 << std::endl;
	if(v1 > v2) return true; // reject point b, right turn
	return false; // otherwise accept point b
}


int main() {
    //Point a(0, 2);
    //Point b(3, 2);
    // Point c(1, 4);
    //std::cout << det(a, b) << std::endl;
	load_obj("./polygon.obj");
    return 0;
}