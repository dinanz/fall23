////////////////////////////////////////////////////////////////////////////////
#include <algorithm>
#include <complex>
#include <fstream>
#include <iostream>
#include <numeric>
#include <vector>
////////////////////////////////////////////////////////////////////////////////

typedef std::complex<double> Point;
typedef std::vector<Point> Polygon;

double inline det(const Point &u, const Point &v) {
	// TODO
	return 0;
}

// Return true iff [a,b] intersects [c,d], and store the intersection in ans
bool intersect_segment(const Point &a, const Point &b, const Point &c, const Point &d, Point &ans) {
	// [a,b], [c, d]
	// calculate slope, get point of intersection of slopes
	// a = query
	// b = horizontal extension so slope = 0
	// calculate point of intersect
	// if pi.y > c.y and pi.y < d.y or pi.y > d.y and pi.y < c.y
	// and if pi.x > a.x and pi.x < b.x
	// then true
	// using y = ax + b
	// y = a.imag(), x = (y-b)/a
	double slope = (d.imag()-c.imag())/(d.real()-c.real());
	double intercept = c.imag()-(slope*c.real());
	double px = ((a.imag())-intercept)/slope;
	if((px > a.real() && px < b.real()) && 
			(a.imag() < c.imag() != a.imag() < d.imag())) {
		return true;
	}
	return false;
}

////////////////////////////////////////////////////////////////////////////////

bool is_inside(const Polygon &poly, const Point &query) {
	// 1. Compute bounding box and set coordinate of a point outside the polygon
	int xmax = poly[0].real();
	for(int i = 1; i < poly.size(); i++){
		if(poly[i].real() > xmax){
			xmax = poly[i].real();
		}
	}
	// horizontal line segment
	Point outside(xmax + 1, query.imag()); // further ritght than rightmost in polygon
	// 2. Cast a ray from the query point to the 'outside' point, count number of intersections
	int count = 0;
	Point ans;
	for(int i = 1; i < poly.size(); i++){
		// for line [i-1, i], check if [query, outside] intersects
		if(intersect_segment(query, outside, poly[i-1], poly[i], ans)){
			count += 1;

		} 
	}
	if(count%2 == 1) {
		return true;
	}

	return false;
}

////////////////////////////////////////////////////////////////////////////////

std::vector<Point> load_xyz(const std::string &filename) {
	std::vector<Point> points;
	std::ifstream in(filename);
	// load points in file to points vector
	if(in.is_open()){
		// parse line by line, store into points
		// points.push_back(complex(line[0], line[1]))
		std::string s;
		std::string temp;
		std::vector<std::string> vs;
		std::getline(in, s);
		int pointCount = std::stoi(s);

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
	return points;
}

Polygon load_obj(const std::string &filename) {
	std::ifstream in(filename);
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
	return res;
}

void save_xyz(const std::string &filename, const std::vector<Point> &points) {
	std::ofstream out(filename);
	if (!out.is_open()) {
		throw std::runtime_error("failed to open file " + filename);
	}
	out << std::fixed;
	out << points.size() << "\n";
	for (const auto &v : points) {
		out << v.real() << ' ' << v.imag() << " 0\n";
	}
	out << std::endl;
}


////////////////////////////////////////////////////////////////////////////////

int main(int argc, char * argv[]) {
	if (argc <= 3) {
		std::cerr << "Usage: " << argv[0] << " points.xyz poly.obj result.xyz" << std::endl;
	}
	std::vector<Point> points = load_xyz(argv[1]);
	Polygon poly = load_obj(argv[2]);

	std::vector<Point> result;
	for (size_t i = 0; i < points.size(); ++i) {
		if (is_inside(poly, points[i])) {
			result.push_back(points[i]);
		}
	}
	save_xyz(argv[3], result);
	return 0;
}
