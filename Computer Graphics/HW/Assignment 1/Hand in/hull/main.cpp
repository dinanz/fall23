////////////////////////////////////////////////////////////////////////////////
#include <algorithm>
#include <complex>
#include <fstream>
#include <iostream>
#include <numeric>
#include <vector>
#include <string>
////////////////////////////////////////////////////////////////////////////////

typedef std::complex<double> Point; // .rael() = x, .imag() = y
typedef std::vector<Point> Polygon;

double inline det(const Point &u, const Point &v) {
	return u.real()*v.imag()-u.imag()*v.real();
}

bool inline salientAngle(Point &a, Point &b, Point &c) {
	// determine if three points form a triangle (right turn) salient angle
	if(((b.imag()-a.imag())*(c.real()-b.real())-(b.real()-a.real())*(c.imag()-b.imag())) > 0) return true; // salient angle, reject point b
	return false; // otherwise accept point b
}

struct Compare {
	// struct itself called liked a function
	// Compare c; c()
	Point p0; // Leftmost point of the poly
	bool operator ()(const Point &p1, const Point &p2) {
		// if p1 p0 p2 is right turn, then p1 comes before p2
		Point temp1 = (Point) p1;
		Point temp2 = (Point) p2;

		return salientAngle(temp1, p0, temp2);
	}
};



////////////////////////////////////////////////////////////////////////////////

Polygon convex_hull(std::vector<Point> &points) {
	Compare order;
	// get bottom left
	double bottom = points[0].imag(), left = points[0].real();
	for(int i = 1; i < points.size(); i++){
		if(points[i].imag() < bottom ||
			 (points[i].imag() == bottom && points[i].real() < left)){
			bottom = points[i].imag();
			left = points[i].real();
		}
	}
	order.p0 = Point(left, bottom);
	std::sort(points.begin(), points.end(), order);
	Polygon hull;
	// use salientAngle(a, b, c) here
	hull.push_back(points[0]);
	hull.push_back(points[1]);

	for(int i = 2; i < points.size(); i++){
		// for each point, consider hull[end-1], hull[end], points[i]
		// if salientangle(a, b, c) then pop end
		// keep poppinjg until !salientangle
		while(salientAngle(hull[hull.size()-2], hull[hull.size()-1], points[i])){
			hull.pop_back();
		}
		hull.push_back(points[i]);
	}
	return hull;
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

void save_obj(const std::string &filename, Polygon &poly) {
	std::ofstream out(filename);
	if (!out.is_open()) {
		throw std::runtime_error("failed to open file " + filename);
	}
	out << std::fixed;
	for (const auto &v : poly) {
		out << "v " << v.real() << ' ' << v.imag() << " 0\n";
	}
	for (size_t i = 0; i < poly.size(); ++i) {
		out << "l " << i+1 << ' ' << 1+(i+1)%poly.size() << "\n";
	}
	out << std::endl;
}

////////////////////////////////////////////////////////////////////////////////

int main(int argc, char * argv[]) {
	if (argc <= 2) {
		std::cerr << "Usage: " << argv[0] << " points.xyz output.obj" << std::endl;
	}
	std::vector<Point> points = load_xyz(argv[1]);
	Polygon hull = convex_hull(points);
	save_obj(argv[2], hull);
	return 0;
}
