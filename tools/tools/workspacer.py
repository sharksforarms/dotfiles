import tomlkit
import os

w_data = None
w_toml = 'Cargo.toml'
with open(w_toml, 'r') as f:
    w_data = tomlkit.load(f)

members = w_data['workspace']['members']

deps = {}

for member in members:
    m_toml = os.path.join(member, 'Cargo.toml')
    with open(m_toml, 'r') as f:
        m_data = tomlkit.load(f)
        for dep_name, value in m_data['dependencies'].items():
            d_key = dep_name

            # dep_name = "version"
            if isinstance(value, tomlkit.items.String):
                version = value
                if d_key not in deps:
                    deps[d_key] = {'name': dep_name, 'count': 1,
                                   'versions': [version], 'sources': [m_toml], 'is_path': False}
                else:
                    deps[d_key]['count'] += 1
                    deps[d_key]['versions'].append(version)
                    deps[d_key]['sources'].append(m_toml)

            # dep_name = { version = "", ... }
            if isinstance(value, tomlkit.items.InlineTable):
                version = None
                is_path = False
                if 'version' in value:
                    version = value['version']

                if 'path' in value:
                    version = value['path']
                    is_path = True

                if 'workspace' in value:
                    continue

                if version is None:
                    print('skipping', value)
                    continue

                if d_key not in deps:
                    deps[d_key] = {'name': dep_name, 'count': 1,
                                   'versions': [version], 'sources': [m_toml], 'is_path': is_path}
                else:
                    deps[d_key]['count'] += 1
                    deps[d_key]['versions'].append(version)
                    deps[d_key]['sources'].append(m_toml)


n = 2


def largest_ver(vers):
    fvers = []
    for v in vers:
        orig_v = v
        v = v.replace('^', '')
        if '.' in v:
            c = 1
            toks = map(int, v.split('.')[::-1])
            tot = 0
            for t in toks:
                tot += c * t
                c *= 100
            fvers.append((orig_v, tot))
        else:
            fvers.append((orig_v, int(v)))

    fvers = [x[0] for x in sorted(fvers, key=lambda x: x[1], reverse=True)]
    return fvers[0]


for k, v in deps.items():
    name = v['name']
    count = v['count']
    is_path = v['is_path']
    if is_path:
        assert len(set(v['versions'])) == 1
        version = v['versions'][0]
    else:
        version = largest_ver(set(v['versions']))
    sources = v['sources']
    print(name, count, version, sources)

    if count < n:
        continue

    w_data = None
    with open(w_toml, 'r') as f:
        print(w_toml)
        w_data = tomlkit.load(f)

    with open(w_toml, 'w') as f:
        if 'dependencies' not in w_data['workspace']:
            w_data['workspace']['dependencies'] = {}

        if is_path:
            wpath = tomlkit.inline_table()
            wpath.update({'path': version})
            w_data['workspace']['dependencies'][name] = wpath
        else:
            w_data['workspace']['dependencies'][name] = version

        tomlkit.dump(w_data, f)

    for m_toml in sources:
        m_data = None
        with open(m_toml, 'r') as f:
            m_data = tomlkit.load(f)

        with open(m_toml, 'w') as f:
            dep = m_data['dependencies'][name]

            if isinstance(dep, tomlkit.items.String):
                wspace = tomlkit.inline_table()
                wspace.update({'workspace': True})
                m_data['dependencies'].update({name: wspace})

            if isinstance(dep, tomlkit.items.InlineTable):
                m_data['dependencies'][name]['workspace'] = True
                if 'version' in m_data['dependencies'][name]:
                    del m_data['dependencies'][name]['version']
                if 'path' in m_data['dependencies'][name]:
                    del m_data['dependencies'][name]['path']

            tomlkit.dump(m_data, f)
