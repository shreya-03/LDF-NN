#include <bits/stdc++.h>
using namespace std;

string t[33];
vector<int > v;

void compute()
{
	int it = 0;
	for (int i = 0;i < 32;i+=4)
	{
		for (int j = 0;j < 32;j += 4)
		{
			int cnt = 0;
			for (int k = i;k < (i + 4);k++)
			{
				for (int l = j;l < (j + 4);l++)
				{
					if (t[k][l] == '1')cnt++;
				}
			}
			v.push_back(cnt);
		}
	}
}

int main()
{
	freopen("data.txt","r",stdin);
	freopen("output.txt","w",stdout);
	int n = 31218;
	for (int i = 1;i <= n;i++)
	{
		string s;
		if (i % 33 == 0)
		{
			cin>>s;
			if (s[0] == '0' || s[0] == '1' || s[0] == '7')
			{
				compute();
				int sz = v.size();
				sz = sqrt(sz);
				for (int j = 0;j < v.size();j++)
					cout << v[j] << ",";
				v.clear();
				if(s[0]=='0')
					cout<< "0,0" << endl;
				else if(s[0]=='1')
					cout<< "0,1" << endl;
				else
					cout<< "1,1" <<endl;
//				cout << s << endl;
			}
		}
		else
			cin >> t[(i - 1) % 32];
	}
	return 0;
}