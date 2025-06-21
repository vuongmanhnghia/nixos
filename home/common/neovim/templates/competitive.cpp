#include <bits/stdc++.h>
using namespace std;

// Common typedefs
#define ll long long
#define ull unsigned long long
#define ld long double
#define vi vector<int>
#define vll vector<long long>
#define vvi vector<vector<int>>
#define vvll vector<vector<long long>>
#define pii pair<int, int>
#define pll pair<long long, long long>
#define vpii vector<pair<int, int>>
#define vpll vector<pair<long long, long long>>

// Common macros
#define all(x) x.begin(), x.end()
#define rall(x) x.rbegin(), x.rend()
#define sz(x) (int)x.size()
#define pb push_back
#define mp make_pair
#define fi first
#define se second

// Loop macros
#define FOR(i, a, b) for (int i = (a); i < (b); i++)
#define FORE(i, a, b) for (int i = (a); i <= (b); i++)
#define RFOR(i, a, b) for (int i = (a); i > (b); i--)
#define RFORE(i, a, b) for (int i = (a); i >= (b); i--)

// Constants
const int MOD = 1e9 + 7;
const int INF = 1e9;
const ll LINF = 1e18;
const ld EPS = 1e-9;

// Utility functions
template<typename T>
void print_vector(const vector<T>& v) {
    for (int i = 0; i < sz(v); i++) {
        cout << v[i] << (i == sz(v) - 1 ? "\n" : " ");
    }
}

template<typename T>
void print_matrix(const vector<vector<T>>& mat) {
    for (const auto& row : mat) {
        print_vector(row);
    }
}

// Fast I/O
void fast_io() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    cout.tie(NULL);
}

// Main solve function
void solve() {
    // Your solution here
    
}

int main() {
    fast_io();
    
    int t = 1;
    // cin >> t;  // Uncomment for multiple test cases
    
    while (t--) {
        solve();
    }
    
    return 0;
} 